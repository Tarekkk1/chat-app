source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.7'
gem 'mysql2', '>= 0.3.18', '< 0.6.0'
gem 'puma', '~> 3.0'
gem 'redis'
gem 'rake'
gem 'redis-rails'
gem 'unicorn'
gem 'elasticsearch-model'
gem 'elasticsearch-rails'

gem 'fast_jsonapi'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'awesome_print'
end

# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
