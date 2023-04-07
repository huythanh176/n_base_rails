# frozen_string_literal: true

class Device < ApplicationRecord
  belongs_to :resourceable, polymorphic: true

  enum platform: {web: 0, ios: 1, android: 2}

  def self.digest_token
    Digest::SHA1.hexdigest([Time.zone.now, rand].join)
  end
end
