# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Lorem.word }
    shelf { Book.shelves.keys.sample }
    author
  end
end
