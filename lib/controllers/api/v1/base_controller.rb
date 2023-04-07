# frozen_string_literal: true

class Api::V1::BaseController < ApplicationController
  attr_reader :current_user
end
