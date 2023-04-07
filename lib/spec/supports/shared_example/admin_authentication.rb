# frozen_string_literal: true

RSpec.shared_examples :admin_authentication do |_action|
  context "when the token is invalid" do
    let(:headers) {{Authorization: "invalid_token"}}

    it "returns a 401 status" do
      expect(response.status).to eq 401
      expect(json_response["success"]).to eq false
      expect(json_response["errors"][0]["code"]).to eq 1204
      expect(json_response["errors"][0]["message"]).to eq "Invalid Token"
    end
  end

  context "when the token is invalid type" do
    let(:headers) {{Authorization: JsonWebToken.encode({id: admin.id, resource_type: "invalid_type"})}}

    it "returns a 401 status" do
      expect(response.status).to eq 401
      expect(json_response["success"]).to eq false
      expect(json_response["errors"][0]["code"]).to eq 1204
      expect(json_response["errors"][0]["message"]).to eq "Invalid Token"
    end
  end

  context "when the token is invalid author resource" do
    let(:headers) {{Authorization: JsonWebToken.encode({id: 0, resource_type: "admin"})}}

    it "returns a 401 status" do
      expect(response.status).to eq 401
      expect(json_response["success"]).to eq false
      expect(json_response["errors"][0]["code"]).to eq 1204
      expect(json_response["errors"][0]["message"]).to eq "Invalid Token"
    end
  end

  context "when the token is invalid device" do
    let(:headers) {{Authorization: JsonWebToken.encode({id: admin.id, resource_type: "admin", device_id: 0})}}

    it "returns a 401 status" do
      expect(response.status).to eq 401
      expect(json_response["success"]).to eq false
      expect(json_response["errors"][0]["code"]).to eq 1204
      expect(json_response["errors"][0]["message"]).to eq "Invalid Token"
    end
  end
end
