# frozen_string_literal: true

module Datasource
  class ExceptionHandler
    class << self
      def handle_datasource_exceptions
        yield
      rescue Exceptions::Datasource::Base => e
        print_error "Error, #{e}"
        exit 1
      end

      def handle_validator_exceptions(line_num = nil)
        yield
      rescue Exceptions::Validator::Base => e
        print_error "Error, line: #{line_num}, Exception: #{e}, temporary ignoring this line"
      end

      private

      def print_error(string)
        # :nocov:
        puts string
        # :nocov:
      end
    end
  end
end
