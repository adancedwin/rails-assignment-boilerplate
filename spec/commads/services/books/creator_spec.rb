# frozen_string_literal: true

require 'rails_helper'

describe Validators::Books::Creator do
  let(:author) { create :author }
  let(:author_params) { { id: author.id.to_s } }
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
    it 'returns success' do
      result = described_class.new.call(params)
      expect(result.success?).to eq(true)
      expect(result.errors.to_h).to eq({})
    end
  end

  context 'negative tests' do
    it 'fails on title is missing' do
      result = described_class.new.call(params.except(:title))

      expect(result.success?).to eq(false)
      expect(result.errors.to_h).to eq({ title: ['is missing'] })
    end

    it 'fails on title must be filled' do
      result = described_class.new.call(params.merge(title: ''))

      expect(result.success?).to eq(false)
      expect(result.errors.to_h).to eq({ title: ['must be filled'] })
    end

    it 'fails on author is missing' do
      result = described_class.new.call(params.except(:author))

      expect(result.success?).to eq(false)
      expect(result.errors.to_h).to eq({ author: ['is missing'] })
    end

    it 'fails on author not found' do
      result = described_class.new.call(params.merge(author: { id: '' }))

      expect(result.success?).to eq(false)
      expect(result.errors.to_h).to eq({ author: ['not found'] })
    end

    it 'fails on author needs to be present' do
      result = described_class.new.call(params.merge(author: { name: '' }))

      expect(result.success?).to eq(false)
      expect(result.errors.to_h).to eq({ author: ['needs to be present'] })
    end

    it 'fails on cover needs to be present' do
      result = described_class.new.call(params.except(:cover))

      expect(result.success?).to eq(false)
      expect(result.errors.to_h).to eq({ cover: ['is missing'] })
    end

    it 'fails on shelf is missing' do
      result = described_class.new.call(params.except(:shelf))

      expect(result.success?).to eq(false)
      expect(result.errors.to_h).to eq({ shelf: ['is missing'] })
    end
  end
end
