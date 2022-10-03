# frozen_string_literal: true

require 'spec_helper'

require_relative root_join 'parser'

RSpec.describe Parser do
  describe 'generate_report' do
    subject { described_class.new.invoke(:generate_report, [], options) }

    let(:options) do
      {
        report: 'PagesOrderedByVisits',
        source_path: root_join('spec', 'log_data', 'correct_example.log'),
        source_type: 'log'
      }
    end

    it 'saves source info into config' do
      Config.clear

      expect { subject }.to change(Config, :source_path).from(nil).to(options[:source_path])
                                                        .and change(Config,
                                                                    :source_type).from(nil).to(options[:source_type])
    end

    it 'load file and write output to stdout' do
      expect { subject }.to output(match(%r{/[a-z_0-9]+ \d+ visits}).and(match(%r{/[a-z_0-9]+ \d+ visits}))).to_stdout
    end
  end

  describe 'service' do
    subject { described_class.new.tap { |parser| parser.options = { report: 'PagesOrderedByVisits' } } }

    it 'returns class of desired service' do
      expect(subject.send(:service)).to be_kind_of(Services::PagesOrderedByVisits)
    end
  end

  describe 'view_class' do
    subject { described_class.new }

    it 'returns class of searched service by name' do
      subject.options = { output_view: 'StdoutVisitsCount' }
      expect(subject.send(:view_class)).to eq(Views::StdoutVisitsCount)
    end

    it 'returns corresponding class for visits count report' do
      subject.options = { report: 'PagesOrderedByVisits' }
      expect(subject.send(:view_class)).to eq(Views::StdoutVisitsCount)
    end

    it 'returns corresponding class for unique visits count report' do
      subject.options = { report: 'PagesOrderedByUniqueVisits' }
      expect(subject.send(:view_class)).to eq(Views::StdoutUniqueVisitsCount)
    end
  end
end
