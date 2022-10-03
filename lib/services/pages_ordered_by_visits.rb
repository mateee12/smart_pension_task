# frozen_string_literal: true

module Services
  class PagesOrderedByVisits < Base
    def execute
      DataTable.all.group(:url, { count: [] }).order(:count, :desc)
    end
  end
end
