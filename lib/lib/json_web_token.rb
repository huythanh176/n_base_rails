# frozen_string_literal: true

module JsonWebToken
  RAILS_SECRET = ENV["RAILS_SECRET_KEY"]

  def self.encode(payload)
    JWT.encode(payload, RAILS_SECRET)
  end

  def self.decode(payload)
    JWT.decode(payload, RAILS_SECRET)[0].transform_keys(&:to_sym)
  end
end
