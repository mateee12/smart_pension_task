# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TableFunction::Unique do
  let(:data_table) do
    DataTable.new([
                    TableRow.new(url: 'google', ip: 1),
                    TableRow.new(url: 'google', ip: 2),
                    TableRow.new(url: 'google', ip: 1),
                    TableRow.new(url: 'twitter', ip: 4),
                    TableRow.new(url: 'twitter', ip: 4)
                  ])
  end
  let(:subject) { data_table.unique(:ip) }

  describe '#unique' do
    it 'creates new table with unique url' do
      res = data_table.unique(:url)

      expect(res.size).to eq(2)
      expect(res[0]).to include(url: 'google', ip: 1)
      expect(res[1]).to include(url: 'twitter', ip: 4)
    end

    it 'creates new table by unique url & ip addresses' do
      res = data_table.unique(:url, :ip)

      expect(res.size).to eq(3)
      expect(res[0]).to eq({ url: 'google', ip: 1 })
      expect(res[1]).to eq({ url: 'google', ip: 2 })
      expect(res[2]).to eq({ url: 'twitter', ip: 4 })
    end
  end
end
