# frozen_string_literal: true

class Api::V1::GenerateAccessTokenService
  def initialize(args)
    @resource = args[:resource]
    @refresh_token = args[:refresh_token]
    @device_id = args[:device_id]
  end

  def execute
    {
      access_token: JsonWebToken.encode(payload),
      refresh_token: refresh_token,
      "#{resource.class.name.downcase}": {
        id: resource.id,
        email: resource.email
      }
    }
  end

  private

  attr_reader :resource, :refresh_token, :device_id

  def payload
    {
      id: resource.id,
      email: resource.email,
      resource_type: resource.class.name,
      device_id: device_id,
      exp: (Time.current + Settings.user.authenticate.access_token.exp.hours).to_i
    }
  end
end
