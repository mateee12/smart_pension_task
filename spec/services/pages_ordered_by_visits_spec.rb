# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Services::PagesOrderedByVisits do
  subject { described_class.new.execute }

  let(:data) do
    DataTable.new [
      TableRow.new(url: 'a', ip_address: '1'),
      TableRow.new(url: 'a', ip_address: '1'),
      TableRow.new(url: 'a', ip_address: '1'),
      TableRow.new(url: 'a', ip_address: '1'),
      TableRow.new(url: 'a', ip_address: '1'),
      TableRow.new(url: 'a', ip_address: '1'),
      TableRow.new(url: 'a', ip_address: '1'),
      TableRow.new(url: 'a', ip_address: '1'),
      TableRow.new(url: 'b', ip_address: '1'),
      TableRow.new(url: 'b', ip_address: '2'),
      TableRow.new(url: 'b', ip_address: '3'),
      TableRow.new(url: 'b', ip_address: '1'),
      TableRow.new(url: 'b', ip_address: '1')
    ]
  end

  before do
    allow(DataTable).to receive(:all).and_return data
  end

  it 'successfully returns expected data result' do
    expect(subject[0]).to include(url: 'a', count: 8)
    expect(subject[1]).to include(url: 'b', count: 5)
  end
end
