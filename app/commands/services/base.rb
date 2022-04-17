# frozen_string_literal: true

module Services
  class Base
    private

    def validate_params(_params)
      raise NoMethodError
    end

    def result_object(result, validator)

      Struct.new(:success?, :errors).new(result, build_error_messages(validator))
    end

    def build_error_messages(validator)
      return [] unless validator

      validator.errors.to_h.each_with_object([]) do |(key, error), message|
        message << "#{key.to_s.titleize} #{error.join(', ')}"
      end
    end
  end
end
