# frozen_string_literal: true

class Book < ApplicationRecord
  enum shelf: %i[read currently_reading want_to_read]

  belongs_to :author

  has_one_attached :cover

  scope :by_shelf, ->(shelf) { where(shelf: shelf) }
end
