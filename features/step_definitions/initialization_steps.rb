Given(/^Zuppler is loaded$/) do
  Zuppler.is_a?(Module).should be_true
end

When(/^I initialize with (.*) and (.*)$/) do |channel, key|
  Zuppler.channel = channel
  Zuppler.api_key = key
end

Then(/^Initialized with (.*) and (.*)$/) do |channel, key|
  Zuppler.channel.should eq(channel)
  Zuppler.api_key.should eq(key)
end
