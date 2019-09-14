ENV['SINATRA_ENV'] ||= "development"

require "bundler/setup"
Bundler.require(:default ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
			#:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
			:adapter => "sqlite3"
			#:host     => db.host,
			#:username => db.user,
			#:password => db.password,
			#:database => db.path[1..-1],
			:database => "db/#{ENV['SINATRA_ENV']}.sqlite"
			:encoding => 'utf8'
	)

require ".app/controllers/application_controller"
require_all "app"