class CucumberLogger
  def info(message)
    puts message
  end

  def debug(message)
    puts message
  end
end

#
# Givens
#
Given(/^Zuppler is loaded$/) do
  Zuppler.is_a?(Module).should be_truthy
end
Given(/^Zuppler configured with "(.*)" and "(.*)"$/) do |channel, key|
  Zuppler.configure do |config|
    config.channel_key = channel
    config.api_key = key
    config.test = true
    config.logger = CucumberLogger.new
    # config.domain = 'zuppler.dev'
  end
end
Given(/^Zuppler application token$/) do
  # Test Oauth app
  za = Zuppler::Application.new 'fd61a191c8b26b364b03eacac66913088abad7e5d144cf0e319d553335e6bbc3', '45669935c634a6cf28f630384cdd6d5bd490983f207005126a9fa1a52fcbbaf6'
  @access_token = za.access_token 'admin'
end

Given(/^Zuppler user token$/) do
  @access_token = 'e4c22df01390e46bb2e7c9e07698e526b3674d5e24a45bc9e173a6fc3560d6c9'
end

#
# Whens
#
When(/^I initialize with (.*) and (.*)$/) do |channel, key|
  Zuppler.configure do |config|
    config.channel_key = channel
    config.api_key = key
    config.test = true
    config.logger = CucumberLogger.new
    # config.domain = 'zuppler.dev'
  end
end
When(/^Zuppler is not initialized$/) do
  Zuppler.init '', ''
end
When(/^Zuppler is initialized$/) do
  Zuppler.channel.should be
  Zuppler.api_key.should be
  Zuppler.test?.should be_truthy
end

#
# Thens
#
Then(/^Is initialized with (.*) and (.*)$/) do |channel, key|
  Zuppler.channel_key.should eq(channel)
  Zuppler.api_key.should eq(key)
  Zuppler.test?.should be_truthy
end
