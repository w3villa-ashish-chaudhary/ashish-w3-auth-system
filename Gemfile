source "https://rubygems.org"

gem "rails", "~> 7.2.3", ">= 7.2.3.1"
gem "sprockets-rails"

# ✅ PostgreSQL (Production)
gem "pg"

# ✅ MySQL (Only for local development)
group :development do
  gem "mysql2", "~> 0.5"
end

gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

# Auth
gem "devise"
gem "omniauth"
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"

# Env variables
gem "dotenv-rails", groups: [:development, :test]

gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
  gem "letter_opener"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end