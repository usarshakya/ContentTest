source "https://rubygems.org"

ruby "3.3.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.3"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1', '>= 3.1.12'

# Library for data serialization
gem 'active_model_serializers', '~> 0.10.14'

group :development, :test do
  # Provides an interactive REPL (Read-Eval-Print Loop) for debugging code
  gem 'pry', '~> 0.14.2'

  # Generates test data
  gem 'factory_bot_rails'

  # Provides mock data for various data types
  gem 'faker'

  # Provides a testing framework (RSpec) for writing tests
  gem 'rspec-rails', '~> 6.1', '>= 6.1.2'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Add a comment summarizing the current schema
  gem 'annotate'

  # Alert to use N+1 queries
  gem 'bullet'
end

group :test do
  # Provides test coverage reporting
  gem 'simplecov', require: false
end
