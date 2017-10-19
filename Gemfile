source 'https://rubygems.org'

gem 'rails', '4.2.5'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'rails_admin'
gem 'sequenced'
gem 'dragonfly', '~> 1.0.12'
gem 'dragonfly-s3_data_store', git: 'https://github.com/vgrigoruk/dragonfly-s3_data_store.git', branch: 'aws_sdk'
gem 'image_size'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# One-line logs
gem 'lograge'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rest-client'
  gem 'rspec-rails'
  gem "factory_girl_rails", "~> 4.0"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'poltergeist'
end

group :demo_test_run do
  gem 'capybara'
  gem 'poltergeist'
  gem 'rmagick'
  gem 'rspec'
  gem 'spectre_client', git: 'https://github.com/wearefriday/spectre_client.git'
end

# Standard Auth0 requirements
gem 'omniauth', '~> 1.3.1'
gem 'omniauth-auth0', '~> 1.4.1'
# Secrets should never be stored in code
gem 'dotenv-rails', require: 'dotenv/rails-now', group: [:development, :test]
