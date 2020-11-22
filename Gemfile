source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootsnap', '~> 1.4.6', require: false
gem 'coffee-rails', '~> 5.0.0'
gem 'jbuilder', '~> 2.10.0'
gem 'jquery-rails', '~> 4.3.3'
gem 'pg', '~> 1.2.3'
gem 'puma', '~> 4.3.5'
gem 'rails', '~> 6.0.2'
gem 'sass-rails', '~> 6.0.0'
gem 'turbolinks', '~> 5.2.0'
gem 'tzinfo-data', '~> 1.2.5', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '~> 4.2.0'

group :development, :test do
  gem 'pry-byebug', '~> 3.9.0' # Use pry to debug, writing "binding.pry"
  gem 'pry-rails', '~> 0.3.6' # Use pry as rails console
  gem 'rspec-rails', '~> 4.0.0' # Use RSpec for testing
end

group :development do
  gem 'better_errors', '~> 2.6.0' # To replace standard Rails error page with a better one
  gem 'binding_of_caller', '~> 0.8.0' # To add a REPL to the better_errors error page
  gem 'listen', '~> 3.2.1'
  gem 'rails-erd', '~> 1.6.0' # To generate model diagrams using Graphviz, a visualisation library
  gem 'spring', '~> 2.1.0'
  gem 'spring-watcher-listen', '~> 2.0.1'
  gem 'web-console', '~> 4.0.1'
end

group :test do
  gem 'capybara', '~> 3.32.1' # Use capybara for feature specs
  gem 'shoulda-matchers', '~> 4.3.0' # Use shoulda to test common Rails functionality
  gem 'simplecov', '>= 0.16.1', require: false # To check code coverage
end

gem 'rubocop', '~> 1.3.1' # Ruby static code analyzer
