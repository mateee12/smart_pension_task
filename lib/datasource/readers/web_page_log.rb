# frozen_string_literal: true

# reads log line by line and yields url and ip address from every line
module Datasource
  module Readers
    class WebPageLog < Base
      attr_reader :file_path

      def initialize(file_path)
        @file_path = file_path
      end

      def readlines(&block)
        validate_log_file

        File.foreach(file_path, &block)
      end

      def parse_line(string)
        Datasource::FormatValidators::WebPageLogLine.validate(string)

        url, ip_address = string.split(' ')
        Datasource::FormatValidators::Url.validate(url)
        Datasource::FormatValidators::IpAddress.validate(ip_address)

        { url:, ip_address: }
      end

      private

      def validate_log_file
        raise Exceptions::Datasource::FileCanNotBeFound unless File.file?(file_path)
      end
    end
  end
end
