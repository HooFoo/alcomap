source 'https://rubygems.org'
ruby '2.3.1'

gem 'puma'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~>4.2.1'

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
#use Angular as JS library
gem 'angularjs-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc


# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Use sqlite3 as the database for Active Record
  #gem 'sqlite3'
  gem 'pg', '0.15.1'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem "rspec-rails", "~> 2.0"
  #gem "factory_girl_rails", "~> 4.0"
  #gem "capybara"
  #gem "database_cleaner"
  #gem "selenium-webdriver"
  gem 'guard'
  gem 'guard-shell'
  gem 'wdm', '>= 0.1.0' if Gem.win_platform?
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'inherited_resources', '~> 1.6.0'
gem 'bootstrap-sass'
gem 'bower-rails'
#gem 'quite_assets'

gem 'devise', '~> 4.2'
gem 'devise_invitable'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'gmaps4rails'
gem 'underscore-rails'
gem "paperclip", "~> 4.3"
gem 'lazy_columns'
gem 'hashie'

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end