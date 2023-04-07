# frozen_string_literal: true

class ActionNotAllowedSerializer
  def initialize(error)
    @error = error
  end

  def serialize
    {
      success: false,
      errors: [I18n.t(:not_allowed, scope: %i[errors action])]
    }
  end

  private

  attr_reader :error
end
