source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'devise', '~> 4.8.0'
gem 'devise-jwt', '0.9.0'
gem 'rack-cors', '1.1.1'

group :development, :test do
  gem 'factory_bot_rails', '6.2.0'
  gem 'faker', '~> 2.19.0'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 4.1'
end

group :development do
  gem 'annotate', '~> 3.0', '>= 3.0.3'
  gem 'brakeman', '~> 5.1'
  gem 'listen', '~> 3.3'
  gem 'rails_best_practices', '~> 1.20'
  gem 'reek', '~> 6.0.6'
  gem 'rubocop-rails', '~> 2.12', require: false
  gem 'rubocop-rootstrap', '~> 1.2'
  gem 'rubocop-rspec', '2.5.0'
  gem 'spring', '2.1.1'
  gem 'spring-watcher-listen', '~> 2.0.1'
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', '~> 0.13.0', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
