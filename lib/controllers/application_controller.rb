# frozen_string_literal: true

class ApplicationController < ActionController::API
  include BaseConcern

  before_action :authorize_request!

  private

  attr_reader :current_device

  def authorize_request!
    resource_type = request.path.split("/")[2] == "admin" ? "admin" : "user"
    authorization_header = request.headers["Authorization"]
    instance_variable_set "@current_#{resource_type}",
                          Api::AuthorizeRequestService.new(
                            authorization_header: authorization_header,
                            resource_type: resource_type
                          ).perform
  end

  def authorize_refresh_token_request!
    @current_device = Device.find_by(refresh_token: refresh_token)
    raise JWT::DecodeError, :refresh_token_invalid unless current_device
  end

  def refresh_token
    JsonWebToken.decode(params[:refresh_token])[:refresh_token]
  end
end
