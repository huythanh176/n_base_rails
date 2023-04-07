# frozen_string_literal: true

require "rails_helper"

RSpec.describe Device, type: :model do
  context "associations" do
    it {is_expected.to belong_to :resourceable}
  end

  context "enum" do
    it {should define_enum_for(:platform).with_values({web: 0, ios: 1, android: 2})}
  end
end
