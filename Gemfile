# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'activerecord-session_store'
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'friendly_id', '~> 5.4'
gem 'redis', '~> 4.0'
gem 'image_processing', '~> 1.2'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'cocoon'
gem 'faraday'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'geocoder'
gem 'pagy'
gem "lazyload-rails"
gem "accept_language"
gem 'recaptcha'
gem 'stimulus_reflex', '3.4.1'

# Validator
gem 'active_storage_validations'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'rubocop'
  gem 'solargraph'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
