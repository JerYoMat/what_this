require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

use Rack::MethodOverride
