source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.7"

gem "bootsnap", require: false
gem "cssbundling-rails"
gem "devise"
gem "jsbundling-rails"
gem "jbuilder"
gem "omniauth", "~> 2.1"
gem "omniauth-rails_csrf_protection", "~> 2.0"
gem "omniauth-saml", "~> 2.2"
gem "pg", "~> 1.6"
gem "puma", "~> 7.1"
gem "rails", "~> 8.1"
gem "rails-i18n"
gem "simple_form"
gem "sprockets-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "figaro", "~> 1.3"
end

group :development do
  gem "annotaterb"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "webdrivers"
end
