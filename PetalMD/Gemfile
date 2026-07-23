source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# SASS
gem 'sassc-rails'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Authentication
gem 'devise'

# Authorization
gem 'cancancan'

# Procfile
gem 'foreman'

# Haml <3
gem 'haml'

# Pagination
gem 'kaminari'

group :development, :test do
  # RSpec test framework
  gem 'rspec-rails', '~> 4.0.0'
end

group :test do
  # ShouldaMatchers test helpers
  gem 'shoulda-matchers', '~> 4.0'
end

# ElasticSearch
gem 'elasticsearch-model'
gem 'elasticsearch-rails'

# API documentation
gem 'rspec_api_documentation'
# Doc Viewer
# gem 'apitome'
gem "apitome", github: "jejacks0n/apitome" # fix issue #114

# Fix for Nokogiri security issue (nokogiri not an explicit dependency) 
gem "nokogiri", ">= 1.11.0.rc4"

