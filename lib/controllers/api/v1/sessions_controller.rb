# frozen_string_literal: true

class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authorize_request!, only: %i[create refresh]
  before_action :authorize_refresh_token_request!, only: :refresh

  def create
    raise Api::Error::Runtime, :invalid_email unless user&.valid_password?(params[:user][:password])

    device = user.devices.build user_params.except(:email, :password)
    refresh_token = Api::V1::GenerateRefreshTokenService.new(device).execute
    args = {resource: user, refresh_token: refresh_token, device_id: device.id}

    render_jsonapi Api::V1::GenerateAccessTokenService.new(args).execute
  end

  def destroy
    current_user.devices.delete_all

    render_jsonapi({})
  end

  def refresh
    refresh_token = Api::V1::GenerateRefreshTokenService.new(current_device).execute
    args = {resource: current_device.resourceable, refresh_token: refresh_token, device_id: current_device.id}

    render_jsonapi Api::V1::GenerateAccessTokenService.new(args).execute
  end

  private

  def user
    @user ||= User.find_by email: params[:user][:email]
  end

  def user_params
    params.require(:user).permit(:email, :password, :platform)
  end
end
