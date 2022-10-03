# frozen_string_literal: true

module Datasource
  module FormatValidators
    # base class for specific format validators
    class Base
      EXCEPTION = NotImplementedError

      class << self
        def validate(string)
          raise self::EXCEPTION unless validate_format(string)
        end

        def validate_format(string)
          raise NotImplementedError
        end
      end
    end

    # validates line format whether it contains exactly two words splitted with whitespace
    class WebPageLogLine < Base
      EXCEPTION = Exceptions::Validator::WrongFormatOfLine

      def self.validate_format(string)
        string =~ /^\S+ \S+$/
      end
    end

    # validates format of url string
    class Url < Base
      EXCEPTION = Exceptions::Validator::WrongFormatOfUrl

      def self.validate_format(string)
        string =~ %r{^/[a-z0-9_./]+$}
      end
    end

    # validates format of ip address string
    class IpAddress < Base
      EXCEPTION = Exceptions::Validator::WrongFormatOfIpAddress

      def self.validate_format(string)
        string =~ /^[0-9]{3}.[0-9]{3}.[0-9]{3}.[0-9]{3}$/
      end
    end
  end
end
