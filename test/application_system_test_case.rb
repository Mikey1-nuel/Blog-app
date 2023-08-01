require 'test_helper'

WINDOWS_HOST = `cat /etc/resolve.conf | grep nameserver | awk '{print $2}'`.strip
CHROMEDRIVER_URL = "http://#{WINDOWS_HOST}:9515".freeze

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  driven_by :selenium_remote_chrome

  capybara.register_driver :chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--start-maximized')

    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: CHROMEDRIVER_URL
    )
  end

  capybara.configure do |config|
    config.server_host = 'localhost'
    config.server_port = 3000
  end
end
