# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Services::Base do
  subject { Class.new(described_class).new }

  it 'successfully returns expected data result' do
    expect { subject.execute }.to raise_error(NotImplementedError)
  end
end
