# frozen_string_literal: true

require 'rails_helper'

describe Services::Books::Creator do
  let(:author) { create :author }
  let(:cover) { fixture_file_upload('cover_1984.jpg', 'image/jpeg') }
  let(:params) do
    {
      title: Faker::Lorem.word,
      cover: cover,
      shelf: Book.shelves.keys.sample,
      author: author_params
    }
  end

  context 'passes validation' do
    context 'with existing author' do
      let(:author_params) { { id: author.id.to_s } }

      it 'returns success' do
        result = described_class.new.call(params)
        expect(result.success?).to eq(true)
        expect(result.errors).to eq([])
      end

      it 'creates a Book record' do
        object = described_class.new
        expect { object.call(params) }.to change(Book, :count).by(1)
      end
    end

    context 'with new author' do
      let(:author_params) { { name: Faker::Lorem.word } }

      it 'returns success' do
        result = described_class.new.call(params)
        expect(result.success?).to eq(true)
        expect(result.errors).to eq([])
      end

      it 'creates a Book and an Author records' do
        object = described_class.new
        expect { object.call(params) }.to change(Book, :count).by(1)
                                                              .and change(Author, :count).by(1)
      end
    end
  end

  context 'negative tests' do
    let(:author_params) { { name: '' } }

    it 'returns errors object' do
      result = described_class.new.call(params)

      expect(result.success?).to eq(false)
      expect(result.errors).to_not be_empty
    end
  end
end
