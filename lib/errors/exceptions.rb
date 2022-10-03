# frozen_string_literal: true

module Exceptions
  class BaseException < StandardError
  end

  module Datasource
    class Base < BaseException
    end

    class MissingFilePath < Base
    end

    class FileCanNotBeFound < Base
    end
  end

  module Validator
    class Base < BaseException
    end

    class WrongFormatOfLine < Base
    end

    class WrongFormatOfUrl < Base
    end

    class WrongFormatOfIpAddress < Base
    end
  end
end
