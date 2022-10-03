# frozen_string_literal: true

# generates output of manipulated (e.g. sorted) data into desired output (e.g. STDOUT)
module Views
  class StdoutUniqueVisitsCount < Base
    def execute
      puts '', '=== Pages Ordered By Unique Number Of IP Address Visits ==='

      data_table.each_row do |row|
        puts "#{row[:url]} #{row[:count]} unique visits"
      end
    end
  end
end
