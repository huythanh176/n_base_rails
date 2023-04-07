# frozen_string_literal: true

RSpec.shared_context "user_logged_in" do
  let!(:user) {create :user, email: "test@example.com", password: "password"}
  let(:headers) {{Authorization: json_response["data"]["access_token"]}}

  before do
    post api_v1_sign_in_path, params: {user: {email: user.email, password: "password"}}
  end
end

RSpec.shared_context "admin_logged_in" do
  let!(:admin) {create :admin, email: "test@example.com", password: "password"}
  let(:headers) {{Authorization: json_response["data"]["access_token"]}}

  before do
    post api_admin_sign_in_path, params: {admin: {email: admin.email, password: "password"}}
  end
end
