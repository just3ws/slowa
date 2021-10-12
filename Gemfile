# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'biscotti'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

gem 'api-pagination'
gem 'awesome_print'
gem 'kaminari'

gem 'fast_jsonapi'
# gem 'jsonapi-rails'

group :development do
  gem 'annotate', require: false
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
  gem 'fasterer', require: false
  gem 'flog', require: false
  gem 'fuubar', require: false
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'mdl', require: false
  gem 'mry', require: false
  gem 'pry-rails'
  gem 'reek', require: false
  gem 'rspec-rails', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-thread_safety', require: false
  gem 'ruby-lint', require: false
  gem 'rubycritic', require: false
  gem 'sandi_meter', require: false
end

group :development, :test do
  gem 'byebug', require: false
  gem 'faker', require: false
  gem 'pry', require: false
  gem 'pry-byebug', require: false
end

group :test do
  gem 'rspec_junit_formatter', require: false
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
end
