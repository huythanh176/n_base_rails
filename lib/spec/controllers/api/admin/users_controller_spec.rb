# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::Admin::UsersController, type: :request do
  describe "GET #index" do
    include_context "admin_logged_in"
    let!(:user_1) {create :user}
    let!(:user_2) {create :user}
    let!(:user_3) {create :user}

    let(:params) do
      {
        page: 1,
        items: 2
      }
    end

    before do
      get api_admin_users_path, headers: headers, params: params
    end

    context "when logged out success" do
      it "should return status 200" do
        expect(response.status).to eq 200
        expect(json_response["success"]).to eq true
        expect(json_response["data"]["users"].size).to eq 2
        expect(json_response["data"]["users"][0]["id"]).to eq user_1.id
        expect(json_response["data"]["users"][1]["id"]).to eq user_2.id
      end
    end

    include_examples :admin_authentication
  end
end
