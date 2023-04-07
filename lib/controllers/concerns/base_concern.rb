# frozen_string_literal: true

module BaseConcern
  extend ActiveSupport::Concern

  include JsonRenderer
  include RescueException
  include Pagination
end
