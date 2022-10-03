# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TableFunction::Group do
  let(:data_table) do
    DataTable.new([
                    TableRow.new(url: 'google', ip: 1),
                    TableRow.new(url: 'google', ip: 1),
                    TableRow.new(url: 'google', ip: 1),
                    TableRow.new(url: 'google', ip: 2),
                    TableRow.new(url: 'twitter', ip: 1),
                    TableRow.new(url: 'twitter', ip: 1),
                    TableRow.new(url: 'twitter', ip: 2),
                    TableRow.new(url: 'twitter', ip: 2),
                    TableRow.new(url: 'twitter', ip: 3),
                    TableRow.new(url: 'twitter', ip: 4)
                  ])
  end
  let(:columns) { :url }
  let(:aggregate_functions) { { count: [] } }
  let(:subject) { data_table.group(columns, aggregate_functions) }

  describe '#group' do
    context 'with url and then count rows' do
      it do
        expect(subject.size).to eq(2)
        expect(subject[0]).to eq(url: 'google', count: 4)
        expect(subject[1]).to eq(url: 'twitter', count: 6)
      end
    end

    context 'with url and then count only rows with unique ip address' do
      let(:aggregate_functions) { { unique: [:ip], count: [] } }

      it do
        expect(subject.size).to eq(2)
        expect(subject[0]).to eq(url: 'google', count: 2)
        expect(subject[1]).to eq(url: 'twitter', count: 4)
      end
    end
  end
end
