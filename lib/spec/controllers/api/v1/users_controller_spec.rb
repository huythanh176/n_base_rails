# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::SessionsController, type: :request do
  describe "GET #show" do
    include_context "user_logged_in"

    before do
      get api_v1_user_path(user.id), headers: headers
    end

    context "when get user details success" do
      it "should return status 200" do
        expect(response.status).to eq 200
        expect(json_response["success"]).to eq true
        expect(json_response["data"]["user"].present?).to eq true
      end
    end

    include_examples :user_authentication
  end
end
