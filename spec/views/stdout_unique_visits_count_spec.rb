# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Views::StdoutUniqueVisitsCount do
  subject { described_class.new(data, nil).execute }

  let(:data) do
    DataTable.new [
      TableRow.new(url: '/page1', count: 4),
      TableRow.new(url: '/page2', count: 2)
    ]
  end

  it 'prints output of hash table to stdout' do
    expect { subject }.to output(match('/page1 4 unique visits').and(match('/page2 2 unique visits'))).to_stdout
  end
end
