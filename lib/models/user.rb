# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid

  devise :database_authenticatable, :registerable, :validatable

  has_many :devices, as: :resourceable, dependent: :destroy
end
