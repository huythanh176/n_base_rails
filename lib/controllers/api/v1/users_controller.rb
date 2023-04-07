# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::BaseController
  def show
    render_jsonapi current_user, type: :user_details
  end
end
