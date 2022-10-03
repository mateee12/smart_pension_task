# frozen_string_literal: true

module Views
  class Base
    attr_reader :data_table, :output

    def initialize(data_table, output = nil)
      @data_table = data_table
      @output = output
    end

    def execute
      raise NotImplementedError
    end
  end
end
