#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'loader'
require 'thor'

class Parser < Thor
  package_name 'App'

  SERVICE_BY_NAME = {
    'PagesOrderedByVisits' => Services::PagesOrderedByVisits,
    'PagesOrderedByUniqueVisits' => Services::PagesOrderedByUniqueVisits
  }.freeze
  VIEW_BY_NAME = {
    'StdoutGeneric' => Views::StdoutGeneric,
    'StdoutVisitsCount' => Views::StdoutVisitsCount,
    'StdoutUniqueVisitsCount' => Views::StdoutUniqueVisitsCount
  }.freeze

  desc 'generate_report', 'generate report of certain type from data source file'
  method_option :source_path, type: :string, required: true
  method_option :source_type, type: :string, required: true, enum: %w[log csv]
  method_option :report, type: :string, required: true, enum: SERVICE_BY_NAME.keys
  method_option :output_view, type: :string, enum: VIEW_BY_NAME.keys
  method_option :output_destination, type: :string, required: false, default: 'stdout'
  def generate_report
    save_source_info
    data = service.execute
    view(data).execute
  end

  private

  def save_source_info
    Config.clear
    Config.source_path = options[:source_path]
    Config.source_type = options[:source_type]
  end

  def service
    SERVICE_BY_NAME[options[:report]].new
  end

  def view(data)
    view_class.new(data, options[:output_destination])
  end

  def view_class
    if options[:output_view]
      VIEW_BY_NAME[options[:output_view]]
    else
      case service
      when Services::PagesOrderedByVisits
        Views::StdoutVisitsCount
      when Services::PagesOrderedByUniqueVisits
        Views::StdoutUniqueVisitsCount
      end
    end
  end
end

Parser.start(ARGV)
