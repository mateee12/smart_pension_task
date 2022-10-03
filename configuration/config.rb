# frozen_string_literal: true

require 'singleton'

class Config
  include Singleton

  attr_accessor :source_path, :source_type

  class << self
    def source_path=(source_path)
      instance.source_path = source_path
    end

    def source_path
      instance.source_path
    end

    def source_type=(source_path)
      instance.source_type = source_path
    end

    def source_type
      instance.source_type
    end

    def clear
      instance.source_path = nil
      instance.source_type = nil
    end
  end
end
