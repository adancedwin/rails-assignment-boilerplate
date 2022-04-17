# frozen_string_literal: true

module Presenters
  module Books
    # Provides data that's used when adding a new book
    class New < Base
      include Helpers::BookHelper

      def call(book_resource)
        {
          book: book_resource,
          errors: [],
          authors: authors_for_select,
          book_shelves: book_shelves_for_select
        }
      end
    end
  end
end
