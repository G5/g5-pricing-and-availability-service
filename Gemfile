source "https://rubygems.org"
ruby "2.2.2"

gem "rails", "4.1.7"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "turbolinks"
gem "jbuilder", "~> 1.2"
gem "ranked-model"
gem "microformats2"
gem "g5_updatable"

group :assets do
  gem "sass-rails", "~> 4.0.0"
  gem "bourbon", "~> 3.1.8"
  gem "uglifier", ">= 1.3.0"
  gem "coffee-rails", "~> 4.0.0"
end

group :development, :test do
  gem "sqlite3"
  gem "rspec-rails", "~> 2.14.0"
  gem "capybara"
  # We need drag_by support on native elements:
  # https://github.com/teampoltergeist/poltergeist/pull/552
  # This should be released with v1.6.1 or v1.7.0
  gem "poltergeist", github: "teampoltergeist/poltergeist", ref: "f826d135dd54a91f674992e2b5cab60a081e39c"
  gem "database_cleaner", "~> 1.0.1"
  gem "foreman"
  gem "fabrication"
  gem "faker"
  gem "pry-byebug"
end

group :production do
  gem "rails_12factor"
  gem "pg"
  gem "newrelic_rpm"
  gem "honeybadger"
  gem "lograge"
  gem "unicorn"
end

group :doc do
  gem "sdoc", require: false
end
