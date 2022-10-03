# frozen_string_literal: true

class DataTable < Array
  include TableFunction::Group
  include TableFunction::Count
  include TableFunction::Order
  include TableFunction::Unique

  DEFAULT_ROW_CLASS = TableRow

  attr_reader :row_class

  def initialize(rows = [])
    super

    @row_class = rows.first&.class || DEFAULT_ROW_CLASS
  end

  def each_row(&block)
    each(&block)
  end

  def self.all(row_class = DEFAULT_ROW_CLASS)
    @row_class = row_class

    new.tap do |data_table|
      Datasource::Delegator.read_all_data do |row_data|
        row = row_class.new
        data_table.push row.merge(row_data)
      end
    end
  end
end
