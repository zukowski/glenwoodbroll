source 'http://rubygems.org'

gem 'rails', '3.0.9'

gem 'devise', '1.2.rc2'
gem 'cancan'
gem 'rubyzip', :require => 'zip/zip'
gem 'aws'

gem 'jquery-rails'

group :production do
  gem 'passenger'
  gem 'mysql2', '0.2.6'
end

group :test do
  gem 'factory_girl_rails', :require => false
  gem 'rspec-rails', '2.6.0'
  gem 'shoulda'
  gem 'faker'
  gem 'spork', '0.9.0.rc8'
end

group :development, :test do
  gem 'sqlite3'
  gem 'capistrano'
end
