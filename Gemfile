source "https://rubygems.org"

gem "rails", "~> 7.2.1"
gem "pg", "~> 1.5", ">= 1.5.7"
gem "puma", ">= 5.0"
gem 'tzinfo-data'
gem "bootsnap", require: false
gem "rack-cors"
gem "devise-jwt"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
end

group :development do
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "spring"
  gem "pry"
  gem "pry-rails"
end
