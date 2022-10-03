# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TableFunction::Order do
  let(:data_table) do
    DataTable.new([
                    TableRow.new(url: 2),
                    TableRow.new(url: 1),
                    TableRow.new(url: 3)
                  ])
  end
  let(:column) { :url }
  let(:direction) { :asc }
  let(:subject) { data_table.order(column, direction) }

  describe '#order' do
    context 'with column url in ascending order' do
      it do
        expect(subject.size).to eq(3)
        expect(subject.map { |row| row[:url] }).to eq([1, 2, 3])
      end
    end

    context 'with column url in descending order' do
      let(:direction) { :desc }

      it do
        expect(subject.size).to eq(3)
        expect(subject.map { |row| row[:url] }).to eq([3, 2, 1])
      end
    end
  end
end
