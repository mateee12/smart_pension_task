# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_examples 'validate' do |string, should_raise|
  let(:something) { parameter }

  it 'check validation of given string' do
    if should_raise
      expect { described_class.validate(string) }.to raise_error(described_class::EXCEPTION)
    else
      expect { described_class.validate(string) }.not_to raise_error
    end
  end
end

describe Datasource::FormatValidators do
  describe Datasource::FormatValidators::WebPageLogLine do
    include_examples 'validate', 'some some'
    include_examples 'validate', '/index 200.017.277.774'

    include_examples 'validate', 'some ', true
    include_examples 'validate', ' ', true
    include_examples 'validate', '', true
    include_examples 'validate', 'some some some', true
  end

  describe Datasource::FormatValidators::Url do
    include_examples 'validate', '/index'
    include_examples 'validate', '/index/2'
    include_examples 'validate', '/index_some/2'
    include_examples 'validate', '/index/2/some/3'

    include_examples 'validate', 'index', true
    include_examples 'validate', '.', true
    include_examples 'validate', '/some/:?:!', true
  end

  describe Datasource::FormatValidators::IpAddress do
    include_examples 'validate', '001.001.001.100'
    include_examples 'validate', '100.112.133.999'

    include_examples 'validate', '1.1.1.1', true
    include_examples 'validate', '001.001.001', true
    include_examples 'validate', '001.001.001.222.56', true
  end

  describe Class.new(Datasource::FormatValidators::Base) do
    it 'fail when custom validator does not implement validation method' do
      expect { described_class.validate_format('some') }.to raise_error(NotImplementedError)
    end
  end
end
