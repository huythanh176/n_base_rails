# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::SessionsController, type: :request do
  describe "POST #create" do
    let!(:user) {create :user, email: "emailtest@gmail.com", password: "Aa@123456"}
    let(:params) do
      {
        user: {
          email: "emailtest@gmail.com",
          password: "Aa@123456"
        }
      }
    end

    before do
      post api_v1_sign_in_path, params: params
    end

    context "when login success" do
      it "should return status 200" do
        expect(response.status).to eq 200
        expect(json_response["success"]).to eq true
        expect(json_response["data"]["access_token"].present?).to eq true
        expect(json_response["data"]["refresh_token"].present?).to eq true
        expect(json_response["data"]["user"]["id"]).to eq user.id
        expect(json_response["data"]["user"]["email"]).to eq "emailtest@gmail.com"
        expect(user.reload.devices.present?).to eq true
      end
    end

    context "when invalid email or password" do
      let(:params) do
        {
          user: {
            email: "emailtest@gmail.com",
            password: "Aa@123456bb"
          }
        }
      end

      it "should return status 400" do
        expect(response.status).to eq 400
        expect(json_response["success"]).to eq false
        expect(json_response["errors"][0]["code"]).to eq 1203
        expect(json_response["errors"][0]["message"]).to eq "Invalid email or password"
      end
    end
  end

  describe "POST #refresh" do
    let(:user) {create :user}
    let!(:device) {create :device, resourceable: user}

    let(:params) do
      {
        refresh_token: Api::V1::GenerateRefreshTokenService.new(device).execute
      }
    end

    before do
      post api_v1_refresh_path, params: params
    end

    context "when refresh token success" do
      it "should return status 200" do
        expect(response.status).to eq 200
        expect(json_response["success"]).to eq true
        expect(json_response["data"]["access_token"].present?).to eq true
        expect(json_response["data"]["refresh_token"].present?).to eq true
        expect(json_response["data"]["user"]["id"]).to eq user.id
        expect(json_response["data"]["user"]["email"]).to eq user.email
      end
    end

    context "when refresh token not correct" do
      let(:params) do
        {
          refresh_token: JsonWebToken.encode({refresh_token: "not_correct"})
        }
      end

      it "should return status 401" do
        expect(response.status).to eq 401
        expect(json_response["success"]).to eq false
        expect(json_response["errors"][0]["code"]).to eq 1204
        expect(json_response["errors"][0]["message"]).to eq "Invalid Token"
      end
    end

    context "when refresh token expired" do
      let(:params) do
        {
          refresh_token: JsonWebToken.encode({exp: (Time.current - 1.hour).to_i})
        }
      end

      it "should return status 401" do
        expect(response.status).to eq 401
        expect(json_response["success"]).to eq false
        expect(json_response["errors"][0]["code"]).to eq 1205
        expect(json_response["errors"][0]["message"]).to eq "Token Expired"
      end
    end
  end

  describe "POST #destroy" do
    include_context "user_logged_in"

    before do
      delete api_v1_logout_path, headers: headers
    end

    context "when logged out success" do
      it "should return status 200" do
        expect(response.status).to eq 200
        expect(json_response["success"]).to eq true
        expect(user.devices.blank?).to eq true
      end
    end

    include_examples :user_authentication
  end
end
