# frozen_string_literal: true

module Services
  class PagesOrderedByUniqueVisits < Base
    def execute
      DataTable.all
               .group(:url, { unique: [:ip_address], count: [] })
               .order(:count, :desc)
    end
  end
end
