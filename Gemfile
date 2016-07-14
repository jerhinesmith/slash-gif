source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Tags
gem 'acts-as-taggable-on'

# Custom json serialization
gem 'active_model_serializers'

# Pagination
gem 'kaminari'

group :development, :test do
  # rspec
  gem 'rspec-rails'

  # Development ENV variables
  gem 'dotenv-rails'

  # Fake data!
  gem 'faker'
end

group :development do
  # Awesome print is awesome
  gem 'awesome_print'

  gem 'foreman'

  # Pry it open!
  gem 'pry-rails'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Better errors
  gem 'better_errors'

  # Web console
  gem 'binding_of_caller'
end

group :test do
  # Factories over fixtures
  gem "factory_girl_rails"

  # Database testing
  gem 'database_cleaner'
end

group :production do
  gem 'rails_12factor'
  gem 'puma'
end
