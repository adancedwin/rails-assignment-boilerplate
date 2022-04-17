# frozen_string_literal: true

module Services
  module Books
    class Creator < Services::Base
      def call(params)
        validator = validate_params(params)
        return result_object(false, validator) unless validator.success?

        create_new(params)
        result_object(true, nil)
      end

      private

      def validate_params(params)
        Validators::Books::Creator.new.call(params)
      end

      def create_new(params)
        return create_with_author!(params) if params[:author][:id]

        create_with_new_author!(params)
      end

      def create_with_author!(params)
        params.merge!(author_id: params[:author][:id])
              .delete(:author)
        Book.create!(params)
      end

      def create_with_new_author!(params)
        author = Author.new(params.delete(:author))
        book = Book.new(params)
        book.author = author
        book.save!
      end
    end
  end
end
