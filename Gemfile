source "https://rubygems.org"

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Authentication
gem 'sorcery', '0.16.5'

# CSS/JSのフレームワーク
gem "tailwindcss-rails"

# 画像挿入
gem 'carrierwave', '~> 2.0'
gem "mini_magick"

# LINE連携
gem 'omniauth'
gem 'omniauth-line'

# 環境変数管理
gem 'dotenv-rails', groups: [:development, :test]

# LINE bot
gem 'line-bot-api'

# Pagination
gem 'kaminari'

gem 'config'

# SEO対策
gem 'meta-tags'
gem 'sitemap_generator'

# RubyによるZIPファイル操作
gem 'rubyzip', '~> 2.3.0'

gem "stringio", "3.0.4"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem 'letter_opener_web', '~> 2.0'
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'rubocop', require: false
end


gem "dockerfile-rails", ">= 1.6", :group => :development
