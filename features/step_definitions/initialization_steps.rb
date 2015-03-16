class CucumberLogger
  def info(message)
    puts message
  end

  def debug(message)
    puts message
  end
end

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

Then(/^Is initialized with (.*) and (.*)$/) do |channel, key|
  Zuppler.channel_key.should eq(channel)
  Zuppler.api_key.should eq(key)
  Zuppler.test?.should be_truthy
end
