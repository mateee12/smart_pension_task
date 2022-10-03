# frozen_string_literal: true

module TableFunction
  module Unique
    def unique(*columns)
      self.class.new(uniq { |row| row.slice(*columns) })
    end
  end
end
