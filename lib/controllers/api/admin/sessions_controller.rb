# frozen_string_literal: true

class Api::Admin::SessionsController < Api::Admin::BaseController
  skip_before_action :authorize_request!, only: %i[create refresh]
  before_action :authorize_refresh_token_request!, only: :refresh

  def create
    raise Api::Error::Runtime, :invalid_email unless admin&.valid_password?(params[:admin][:password])

    device = admin.devices.build admin_params.except(:email, :password)
    refresh_token = Api::Admin::GenerateRefreshTokenService.new(device).execute
    args = {resource: admin, refresh_token: refresh_token, device_id: device.id}

    render_jsonapi Api::Admin::GenerateAccessTokenService.new(args).execute
  end

  def destroy
    current_admin.devices.delete_all

    render_jsonapi({})
  end

  def refresh
    refresh_token = Api::Admin::GenerateRefreshTokenService.new(current_device).execute
    args = {resource: current_device.resourceable, refresh_token: refresh_token, device_id: current_device.id}

    render_jsonapi Api::Admin::GenerateAccessTokenService.new(args).execute
  end

  private

  def admin
    @admin ||= Admin.find_by email: params[:admin][:email]
  end

  def admin_params
    params.require(:admin).permit(:email, :password, :platform)
  end
end
