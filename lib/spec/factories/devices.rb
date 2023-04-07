# frozen_string_literal: true

FactoryBot.define do
  factory :device do
    refresh_token {Digest::SHA1.hexdigest([Time.zone.now, rand].join)}
  end
end
