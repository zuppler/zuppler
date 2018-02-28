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
  @access_token = 'ea82ba7cbd993a72bbfbcc80e8d35ea71b659e8c41e5eacf137c42e4f7263d76'
end

Given(/^Zuppler user token$/) do
  @access_token = '1f8639b026344721bd0126b039609835ffa931b44446907acc11a07719fce59a'
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
