# frozen_string_literal: true

module TableFunction
  module Group
    # @param [String, Array<String>] columns list of columns, or just one column
    # @param [Hash<Symbol, Array>] aggregate_functions  aggregation functions to be processed in process of grouping,
    #   Array represents list of arguments passed for aggregation functions
    def group(columns, aggregate_functions)
      self.class.new.tap do |dt|
        group_by { |row| row.slice(*columns) }.each do |grouping_row, rows|
          aggregated_row = apply_aggregation_functions(rows, aggregate_functions)
          new_row = merge_rows(grouping_row, aggregated_row)
          dt.push(new_row)
        end
      end
    end

    private

    def apply_aggregation_functions(rows, aggregate_functions)
      rows = self.class.new(rows)

      aggregate_functions.each do |method, args|
        rows = rows.public_send(method, *args)
      end

      rows.first
    end

    def merge_rows(first_row, second_row)
      row_class.new(first_row).merge(second_row)
    end
  end
end
