# frozen_string_literal: true

# generates output of manipulated (e.g. sorted) data into desired output (e.g. STDOUT)
module Views
  class StdoutGeneric < Base
    def execute
      puts '', '=== Data Table Report ==='

      data_table.each_row do |row|
        puts row
      end
    end
  end
end
