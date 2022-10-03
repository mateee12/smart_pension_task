# frozen_string_literal: true

class TableRow < Hash
  def initialize(hash = {})
    merge!(hash)
  end
end
