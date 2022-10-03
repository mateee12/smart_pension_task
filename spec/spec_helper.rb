# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

def root
  Dir.pwd
end

def root_join(*path)
  "#{root}/#{path.join('/')}"
end

require_relative root_join 'loader'
