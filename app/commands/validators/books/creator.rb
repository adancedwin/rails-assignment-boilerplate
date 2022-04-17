# frozen_string_literal: true

module Validators
  module Books
    class Creator < Base
      params do
        required(:title).filled(:str?)
        required(:author).hash do
          optional(:id).maybe(:str?)
          optional(:name).maybe(:str?)
        end
        required(:shelf).filled(:str?)
        required(:cover)
      end

      rule(:author) do
        if value[:id]
          key.failure('not found') unless Author.exists?(value[:id])
        elsif value[:name].empty?
          key.failure('needs to be present')
        end
      end

      rule(:shelf) do
        key.failure('not found') unless Book.shelves.find { |shelve_name, _v| shelve_name == value }
      end

      rule(:cover) do
        key.failure('can be either .jpeg or .png') unless value.content_type.in?(%w[image/jpeg image/png])
      end
    end
  end
end
