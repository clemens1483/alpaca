source "https://rubygems.org"

gem "sinatra"
gem "activerecord"
gem "sinatra-activerecord"
gem "rake"

group :development, :test do
  gem 'sqlite3'
  gem "sinatra-contrib" #for reloading server when saving changes
end
 
group :production do
  gem 'pg' #postgres
end