# frozen_string_literal: true

module Datasource
  module Readers
    class Base
      # :nocov:
      def readlines
        raise NotImplementedError
      end

      def parse_line(string)
        raise NotImplementedError
      end
      # :nocov:
    end
  end
end
