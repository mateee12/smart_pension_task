# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Views::Base do
  subject { Class.new(described_class).new(nil, nil) }

  it 'prints output of hash table to stdout' do
    expect { subject.execute }.to raise_error(NotImplementedError)
  end
end
