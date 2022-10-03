# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Views::StdoutGeneric do
  subject { described_class.new(data, nil).execute }

  let(:data) do
    DataTable.new [
      TableRow.new(url: '/page1', ip_address: '1'),
      TableRow.new(url: '/page2', ip_address: '1')
    ]
  end

  it 'prints output of hash table to stdout' do
    expect { subject }.to output(match(data[0].to_s).and(match(data[1].to_s))).to_stdout
  end
end
