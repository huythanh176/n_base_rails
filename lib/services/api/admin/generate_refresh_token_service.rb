# frozen_string_literal: true

class Api::Admin::GenerateRefreshTokenService
  def initialize(device)
    @device = device
  end

  def execute
    device.refresh_token = Device.digest_token
    device.save!
    JsonWebToken.encode(payload)
  end

  private

  attr_reader :device

  def payload
    {
      refresh_token: device.refresh_token,
      exp: (Time.current + Settings.admin.authenticate.refresh_token.exp.days).to_i
    }
  end
end
