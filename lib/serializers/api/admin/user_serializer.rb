# frozen_string_literal: true

class Api::Admin::UserSerializer < Api::Admin::BaseSerializer
  attributes :id, :email, :created_at

  FIELD_CUSTOM = {
    user_list: %i[id email]
  }.freeze
end
