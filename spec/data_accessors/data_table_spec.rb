# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DataTable do
  it 'includes table functions' do
    expect(described_class.new).to respond_to(:count, :group, :order, :unique)
  end

  it '#each_row yields every row' do
    row1 = TableRow.new
    row1['a'] = 1
    row2 = TableRow.new
    row2['a'] = 2
    expect { |b| described_class.new([row1, row2]).each_row(&b) }.to yield_successive_args(row1, row2)
  end
end
