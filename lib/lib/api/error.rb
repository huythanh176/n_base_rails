# frozen_string_literal: true

module Api
  class BaseError < StandardError
    attr_reader :code, :message

    def initialize(error)
      @code = error[:code]
      @message = error[:message]
    end

    def serialize
      [{code: @code, message: @message}]
    end

    def to_hash
      {
        success: false,
        errors: serialize
      }
    end
  end

  class ExecuteFailed < BaseError
    attr_reader :type, :file_path, :i18n_scope

    def initialize(error_detail)
      error = I18n.t error_detail, scope: %i[errors action]
      @code = error[:code]
      @message = error[:message]
    end
  end

  module Error
    # TODO: define custom error class (extends the BaseError) here.
    class Runtime < ExecuteFailed
    end

    class RecordNotFound < BaseError
      attr_reader :error

      def initialize(error)
        @error = error
      end

      def to_hash
        RecordNotFoundSerializer.new(error).serialize
      end
    end

    class ActionNotAllowed < BaseError
      attr_reader :error

      def initialize(error)
        @error = error
      end

      def to_hash
        ActionNotAllowedSerializer.new(error).serialize
      end
    end
  end
end
