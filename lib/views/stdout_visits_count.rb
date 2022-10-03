# frozen_string_literal: true

# generates output of manipulated (e.g. sorted) data into desired output (e.g. STDOUT)
module Views
  class StdoutVisitsCount < Base
    def execute
      puts '', '=== Pages Ordered By Number Of Visits ==='

      data_table.each_row do |row|
        puts "#{row[:url]} #{row[:count]} visits"
      end
    end
  end
end
