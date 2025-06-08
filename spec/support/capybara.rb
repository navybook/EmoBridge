Capybara.register_driver :chrome_no_password_manager do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--no-sandbox')
  options.add_argument('--incognito')
  options.add_argument('--disable-extensions')
  options.add_argument('--disable-notifications')
  tmp_profile_dir = "/tmp/chrome-profile-#{SecureRandom.hex(8)}"
  options.add_argument("--user-data-dir=#{tmp_profile_dir}")
  options.add_preference('credentials_enable_service', false)
  options.add_preference('profile.password_manager_enabled', false)
  options.add_preference("profile.password_manager_leak_detection", false)
  Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :chrome_no_password_manager
  end
end
