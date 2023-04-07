# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::Admin::UserSerializer, type: :serializer do
  let(:user) {create :user}

  describe "#users_list" do
    let(:params) {{type: :user_list}}
    let(:serialized_user) {described_class.new(user, params).serializable_hash}

    context "when get correct attributes" do
      it "should includes all attributes" do
        expect(serialized_user[:id]).to eq user.id
        expect(serialized_user[:email]).to eq user.email
        expect(serialized_user).to include(:email, :id)
      end
    end
  end
end
