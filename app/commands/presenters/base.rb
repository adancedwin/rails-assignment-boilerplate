# frozen_string_literal: true

module Presenters
  class Base
    def self.call(*args)
      new.call(*args)
    end

    def call
      raise NoMethodError
    end
  end
end
