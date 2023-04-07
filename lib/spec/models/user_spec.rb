# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  context "associations" do
    it {is_expected.to have_many(:devices).dependent(:destroy)}
  end
end
