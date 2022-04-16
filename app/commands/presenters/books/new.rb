# frozen_string_literal: true

module Presenters
  module Books
    # Provides data that's used when adding a new book
    class New < Base
      def call(book_resource)
        {
          book: book_resource,
          authors: authors,
          book_shelves: book_shelves
        }
      end

      private

      def book_shelves
        Book.shelves.map { |shelve_name, _v| [shelve_name.humanize, shelve_name] }
      end

      def authors
        Author.all.map { |author| [author.name, author.id] }
      end
    end
  end
end
