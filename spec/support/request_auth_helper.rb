require "spec_helper"

module RequestAuthHelper
  def http_login
    if page.driver.browser.respond_to?(:basic_authorize) # rack-test
      page.driver.browser.basic_authorize(ENV['HTTP_BASIC_AUTH_NAME'], ENV['HTTP_BASIC_AUTH_PASSWORD'])
    elsif page.driver.respond_to?(:basic_authorize) # poltergeist
      page.driver.basic_authorize(ENV['HTTP_BASIC_AUTH_NAME'], ENV['HTTP_BASIC_AUTH_PASSWORD'])
    else # selenium-webdriver or unknown
      raise "HTTP Basic Auth is not supported by this driver"
    end
  end
end
