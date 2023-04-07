# frozen_string_literal: true

class Api::V1::BaseSerializer < ActiveModel::Serializer
  def initialize(object, options = {})
    @type = options[:type]
    super(object, options)
  end

  def attributes(*args)
    field_custom = "Api::V1::#{object.class}Serializer".constantize::FIELD_CUSTOM

    super.slice(*field_custom[@type] || super.keys)
  end
end
