# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Datasource::Readers::WebPageLog do
  describe '#readlines' do
    it 'reads whole file line by line' do
      reader = described_class.new(root_join('spec', 'log_data', 'correct_example.log'))
      expect { |b| reader.readlines(&b) }.to yield_control.exactly(3).times
    end

    it 'raises file can not be found error' do
      reader = described_class.new('wrong_path.log')
      expect { |b| reader.readlines(&b) }.to raise_error(Exceptions::Datasource::FileCanNotBeFound)
    end
  end

  describe '#parse_line' do
    subject { described_class.new(root_join('spec', 'log_data', 'correct_example.log')) }

    it 'successfully' do
      expect(subject.parse_line('/home 001.001.001.001')).to include(url: '/home', ip_address: '001.001.001.001')
    end

    context 'with validation error' do
      it 'of wrong log line format' do
        expect do
          subject.parse_line('/home 001.001.001.001 other')
        end.to raise_error(Exceptions::Validator::WrongFormatOfLine)
      end

      it 'of wrong url format' do
        expect { subject.parse_line('home 001.001.001.001') }.to raise_error(Exceptions::Validator::WrongFormatOfUrl)
      end

      it 'of wrong ip address format' do
        expect { subject.parse_line('/home 1.1.1.1') }.to raise_error(Exceptions::Validator::WrongFormatOfIpAddress)
      end
    end
  end
end
