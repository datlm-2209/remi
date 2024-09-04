source "https://rubygems.org"

gem "rails", "~> 7.2.1"
# gem "pg", "~> 1.5", ">= 1.5.7"
gem "sqlite3"
gem "puma", ">= 5.0"
gem "tzinfo-data"
gem "bootsnap", require: false
gem "rack-cors"
gem "devise-jwt"
gem "devise"
gem "jsonapi-serializer"
gem "video_info", "~> 4.2"
# gem 'kaminari'
gem "redis"
gem "config"

group :development, :test do
  gem "rubocop", "~> 1.66", require: false
  gem "byebug", platforms: %i[mri mingw x64_mingw ]
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "shoulda-matchers"
  gem "faker"
  gem "pry"
  gem "pry-rails"
end

group :development do
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "spring"
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem "webdrivers", "~> 5.3"
  gem 'database_cleaner-active_record'
end

gem "dockerfile-rails", ">= 1.6", :group => :development
