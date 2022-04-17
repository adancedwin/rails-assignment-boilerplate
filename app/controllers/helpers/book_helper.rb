# frozen_string_literal: true

module Helpers::BookHelper
  def book_shelves_for_select
    Book.shelves.map { |shelve_name, _v| [shelve_name.humanize, shelve_name] }
  end

  def authors_for_select
    Author.all.map { |author| [author.name, author.id] }
  end
end
