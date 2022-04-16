# frozen_string_literal: true

module Services
  module Books
    class Creator
      def call(params)
        result = validate_params(params.to_h)
        return nil unless result.success?

        create_new!(params)
      end

      private

      def validate_params(params)
        Validators::Books::Creator.new.call(params)
      end

      def create_new!(params)
        Book.create!(params)
      end
    end
  end
end
