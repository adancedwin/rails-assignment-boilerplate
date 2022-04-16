# frozen_string_literal: true

module Validators
  module Books
    class Creator < Base
      params do
        required(:title).filled(:str?)
        required(:author_id)
        required(:shelf).filled(:str?)
        required(:cover).filled(:str?)
      end

      rule(:author_id) do
        key.failure('not found') unless Author.exists?(value)
      end

      rule(:shelf) do
        key.failure('not found') unless Book.shelves.find { |shelve_name, _v| shelve_name == value }
      end

      rule(:cover) do
        key.failure('not found') unless value.content_type.in?(%w[image/jpeg image/png])
      end
    end
  end
end
