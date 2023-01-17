# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

gem 'airbrake'
gem 'aws-sdk-s3'
gem 'bcrypt'
gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'dotenv-rails'
gem 'image_processing'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'pagy'
gem 'pg'
gem 'propshaft'
gem 'puma'
gem 'rails'
gem 'rails-i18n'
gem 'redis'
gem 'ruby-openai'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'web-console'
end
