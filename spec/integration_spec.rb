# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Integration' do
  subject do
    data = service.new.execute
    view.new(data).execute
  end

  let(:source_path) { root_join 'spec', 'log_data', 'webserver.log' }
  let(:service) {}
  let(:view) {}

  before do
    Config.source_path = source_path
    Config.source_type = 'log'
  end

  RSpec.shared_examples 'output matches expectation' do |result|
    it do
      expect { subject }.to(output(match(result)).to_stdout)
    end
  end

  describe 'on big webserver.log' do
    context 'with visits count grouped by url' do
      let(:service) { Services::PagesOrderedByVisits }
      let(:view) { Views::StdoutVisitsCount }

      include_examples(
        'output matches expectation',
        <<~EOF
          /about/2 90 visits
          /contact 89 visits
          /index 82 visits
          /about 81 visits
          /help_page/1 80 visits
          /home 78 visits
        EOF
      )
    end

    context 'with unique ip address visits count grouped by url' do
      let(:service) { Services::PagesOrderedByUniqueVisits }
      let(:view) { Views::StdoutUniqueVisitsCount }

      include_examples(
        'output matches expectation',
        <<~EOF
          /index 23 unique visits
          /home 23 unique visits
          /contact 23 unique visits
          /help_page/1 23 unique visits
          /about/2 22 unique visits
          /about 21 unique visits
        EOF
      )
    end
  end

  describe 'on short shorter_example.log' do
    context 'with unique ip address visits count grouped by url' do
      let(:source_path) { root_join 'spec', 'log_data', 'shorter_example.log' }
      let(:service) { Services::PagesOrderedByUniqueVisits }
      let(:view) { Views::StdoutUniqueVisitsCount }

      include_examples(
        'output matches expectation',
        <<~EOF
          /home 14 unique visits
          /about 13 unique visits
          /about/2 12 unique visits
          /help_page/1 12 unique visits
          /index 10 unique visits
          /contact 10 unique visits
        EOF
      )
    end
  end
end
