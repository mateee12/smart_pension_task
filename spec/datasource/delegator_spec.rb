# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Datasource::Delegator do
  before do
    Config.source_path = root_join('spec', 'log_data', 'correct_example.log')
    Config.source_type = 'log'
  end

  describe 'read all data successfully yields file data' do
    context 'with all lines correct' do
      it do
        allow(Datasource::ExceptionHandler).to receive(:print_error)
        expect { |b| described_class.read_all_data(&b) }.to yield_control.exactly(3).times
        expect(Datasource::ExceptionHandler).not_to have_received(:print_error)
      end
    end

    context 'with wrong format of file line' do
      before do
        Config.source_path = root_join('spec', 'log_data', 'example_with_one_invalid_line.log')
      end

      it do
        allow(Datasource::ExceptionHandler).to receive(:print_error)
        expect { |b| described_class.read_all_data(&b) }.to yield_control.exactly(2).times
        expect(Datasource::ExceptionHandler).to have_received(:print_error)
      end
    end
  end

  describe 'fail and stop while reading data' do
    it 'when datasource file exception is raised' do
      Config.source_path = 'wrong_path.log'

      allow(Datasource::ExceptionHandler).to receive(:print_error)
      expect { |b| described_class.read_all_data(&b) }.to raise_error(SystemExit)
      expect(Datasource::ExceptionHandler).to have_received(:print_error).once
    end

    it 'when the unsupported source type is required' do
      Config.source_type = 'wrong_type'

      expect { |b| described_class.read_all_data(&b) }.to raise_error(NotImplementedError)
    end
  end
end
