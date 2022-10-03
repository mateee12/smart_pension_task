# frozen_string_literal: true

module TableFunction
  module Order
    def order(column, direction)
      ordered_table = sort_by { |row| row[column] }
      ordered_table.reverse! if direction == :desc
      self.class.new(ordered_table)
    end
  end
end
