# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TableFunction::Count do
  let(:data_table) do
    DataTable.new([
                    TableRow.new(a: 1),
                    TableRow.new(a: 2),
                    TableRow.new(a: 3)
                  ])
  end
  let(:subject) { data_table.count }

  describe '#count' do
    it 'sums rows and creates new data table' do
      expect(subject.size).to eq(1)
      expect(subject.first).to eq({ count: 3 })
    end
  end
end
