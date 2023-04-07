# frozen_string_literal: true

class Api::AuthorizeRequestService
  def initialize(args)
    @authorization_header = args[:authorization_header]
    @resource_class = args[:resource_type].to_s.classify
  end

  def perform
    authorize_request!
    verify_author_resource
    author_resource
  end

  private

  attr_reader :authorization_header, :resource_class, :decoded_access_token, :author_resource

  def authorize_request!
    access_token = authorization_header.split.last
    @decoded_access_token = JsonWebToken.decode(access_token)
    raise JWT::DecodeError unless decoded_access_token[:resource_type] == resource_class
  end

  def verify_author_resource
    @author_resource = Class.const_get(resource_class).find_by id: decoded_access_token[:id]
    raise JWT::DecodeError unless author_resource

    raise JWT::DecodeError unless valid_device?
  end

  def valid_device?
    author_resource.devices.find_by(id: decoded_access_token[:device_id])
  end
end
