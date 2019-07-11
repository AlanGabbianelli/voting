source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootsnap', '~> 1.3.0', require: false
gem 'coffee-rails', '~> 4.2.2'
gem 'jbuilder', '~> 2.8.0'
gem 'jquery-rails', '~> 4.3.3'
gem 'pg', '~> 1.0.0'
gem 'puma', '~> 4.0.1'
gem 'rails', '~> 5.2.0'
gem 'sass-rails', '~> 5.0.7'
gem 'turbolinks', '~> 5.2.0'
gem 'tzinfo-data', '~> 1.2.5', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '~> 4.1.10'

group :development, :test do
  gem 'pry-byebug', '~> 3.6.0' # Use pry to debug, writing "binding.pry"
  gem 'pry-rails', '~> 0.3.6' # Use pry as rails console
  gem 'rspec-rails', '~> 3.7.2' # Use RSpec for testing
end

group :development do
  gem 'better_errors', '~> 2.4.0' # To replace standard Rails error page with a better one
  gem 'binding_of_caller', '~> 0.8.0' # To add a REPL to the better_errors error page
  gem 'listen', '~> 3.1.5'
  gem 'rails-erd', '~> 1.5.2' # To generate model diagrams using Graphviz, a visualisation library
  gem 'spring', '~> 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.1'
  gem 'web-console', '~> 3.7.0'
end

group :test do
  gem 'capybara', '~> 3.19.1' # Use capybara for feature specs
  gem 'shoulda-matchers', '~> 3.1.2' # Use shoulda to test common Rails functionality
  gem 'simplecov', require: false # To check code coverage
end

gem 'rubocop', '~> 0.55.0' # Ruby static code analyzer
