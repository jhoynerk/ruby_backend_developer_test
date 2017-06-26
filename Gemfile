source 'https://rubygems.org'
ruby '2.3.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails',     '~> 5.0.2'
gem 'pg',        '~> 0.18'
gem 'puma',      '~> 3.0'
gem 'pry-rails', '~> 0.3.5'
gem 'jwt',       '~> 1.5.6'
gem 'sidekiq',   '~> 4.2.9'
gem 'grape'
gem 'grape-entity'

gem 'dotenv-rails'

group :development, :test do
  gem 'rspec-rails',        '~> 3.5.2'
  gem 'factory_girl_rails', '~> 4.8.0'
  gem 'faker',              '~> 1.7.3'
  gem 'database_cleaner',   '~> 1.5.3'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
