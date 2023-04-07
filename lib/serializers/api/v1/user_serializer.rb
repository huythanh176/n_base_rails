# frozen_string_literal: true

class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes :id, :email, :created_at

  FIELD_CUSTOM = {
    user_details: %i[id email]
  }.freeze
end
