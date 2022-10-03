# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Views::StdoutVisitsCount do
  subject { described_class.new(data, nil).execute }

  let(:data) do
    DataTable.new [
      TableRow.new(url: '/page1', count: 10),
      TableRow.new(url: '/page2', count: 7)
    ]
  end

  it 'prints output of hash table to stdout' do
    expect { subject }.to output(match('/page1 10 visits').and(match('/page2 7 visits'))).to_stdout
  end
end
