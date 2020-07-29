source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'twilio-ruby', '~> 5.39.2'

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

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'factory_bot_rails'
  gem 'dotenv-rails'
  gem 'guard'
end

group :development do
  gem 'spring-commands-rspec'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'rb-fsevent'
  gem "capistrano", '~> 3.11', require: false
  gem 'capistrano-rails', '~> 1.3', require: false
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-rvm'
end
