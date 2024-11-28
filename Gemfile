source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.6"

gem "bootsnap", require: false
gem "cssbundling-rails"
gem "devise"
gem "jsbundling-rails"
gem "jbuilder"
gem "omniauth", "~> 2.1"
gem "omniauth-rails_csrf_protection", "~> 1.0"
gem "omniauth-saml", "~> 2.1"
gem "pg", "~> 1.1"
gem "puma", "~> 6.0"
gem "rails", "~> 7.0"
gem "rails-i18n"
gem "redis", "~> 4.0"
gem "simple_form"
gem "sprockets-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "figaro", "~> 1.2"
end

group :development do
  gem "web-console"
  gem "annotate"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
