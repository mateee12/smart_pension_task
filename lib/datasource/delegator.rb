# frozen_string_literal: true

module Datasource
  class Delegator
    def self.read_all_data
      line_num = 0

      ExceptionHandler.handle_datasource_exceptions do
        reader.readlines do |line|
          ExceptionHandler.handle_validator_exceptions(line_num) do
            yield reader.parse_line(line)
          end

          line_num += 1
        end
      end
    end

    def self.reader
      case Config.source_type
      when 'log'
        Readers::WebPageLog.new(Config.source_path)
      else
        raise NotImplementedError
      end
    end
  end
end
