# frozen_string_literal: true

module Services
  class Base
    def execute
      raise NotImplementedError
    end
  end
end
