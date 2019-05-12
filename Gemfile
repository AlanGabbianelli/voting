source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootsnap', '~> 1.5.1', require: false
gem 'coffee-rails', '~> 5.0.0'
gem 'jbuilder', '~> 2.10.1'
gem 'jquery-rails', '~> 4.4.0'
gem 'pg', '~> 1.2.3'
gem 'puma', '~> 5.0.4'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'sass-rails', '~> 6.0.0'
gem 'turbolinks', '~> 5.2.1'
gem 'tzinfo-data', '~> 1.2.8', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '~> 4.2.0'

group :development, :test do
  gem 'pry-byebug', '~> 3.9.0' # Use pry to debug, writing "binding.pry"
  gem 'pry-rails', '~> 0.3.9' # Use pry as rails console
  gem 'rspec-rails', '~> 4.0.1' # Use RSpec for testing
end

group :development do
  gem 'better_errors', '~> 2.9.1' # To replace standard Rails error page with a better one
  gem 'binding_of_caller', '~> 0.8.0' # To add a REPL to the better_errors error page
  gem 'listen', '~> 3.3.1'
  gem 'rails-erd', '~> 1.6.0' # To generate model diagrams using Graphviz, a visualisation library
  gem 'spring', '~> 2.1.1'
  gem 'spring-watcher-listen', '~> 2.0.1'
  gem 'web-console', '~> 4.1.0'
end

group :test do
  gem 'capybara', '~> 3.33.0' # Use capybara for feature specs
  gem 'shoulda-matchers', '~> 4.4.1' # Use shoulda to test common Rails functionality
  gem 'simplecov', '~> 0.19.1', require: false # To check code coverage
end

gem 'rubocop', '~> 1.3.1' # Ruby static code analyzer
