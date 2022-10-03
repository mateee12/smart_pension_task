# frozen_string_literal: true

module TableFunction
  module Count
    def count
      self.class.new.tap do |dt|
        dt.push(row_class.new(count: size))
      end
    end
  end
end
