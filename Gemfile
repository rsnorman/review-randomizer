source 'https://rubygems.org'

ruby '2.2.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
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
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# For secure authentication
gem 'devise'

# For authorization junk
gem 'cancancan', '~> 1.10'

# For nicer forms and junk
gem 'simple_form'

# For error tracking junk
gem 'rollbar', '~> 2.7.1'

# For better JSON serialization junk
gem 'oj', '~> 2.12.14'

# For sending junk mail
gem 'mailgun_rails'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# For layout, style and junk
gem 'foundation-rails'

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # For testing stuff
  gem 'rspec-rails', '~> 3.0'

  # For fixtures and junk
  gem 'factory_girl_rails'

  # For testing rails junk in models
  gem 'shoulda-matchers'

  # For faking names, emails, and junk
  gem 'faker'

  # For making sure my codez isn't junk
  gem 'rubocop'

  # For making sure I don't do stupid security junk
  gem 'brakeman'
end

group :test do
  gem "codeclimate-test-reporter", require: nil
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
