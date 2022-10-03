# frozen_string_literal: true

require_relative 'configuration/config'

require_relative 'lib/errors/exceptions'

require_relative 'lib/datasource/format_validators'
require_relative 'lib/datasource/exception_handler'
require_relative 'lib/datasource/delegator'
require_relative 'lib/datasource/readers/base'
Dir['lib/datasource/readers/*.rb'].sort.each do |file|
  require_relative file
end

Dir['lib/data_accessors/table_function/*.rb'].sort.each do |file|
  require_relative file
end
require_relative 'lib/data_accessors/table_row'
require_relative 'lib/data_accessors/data_table'

require_relative 'lib/services/base'
Dir['lib/services/*.rb'].sort.each do |file|
  require_relative file
end

require_relative 'lib/views/base'
Dir['lib/views/*.rb'].sort.each do |file|
  require_relative file
end
