Given(/^Zuppler is loaded$/) do
  Zuppler.is_a?(Module).should be_true
end

When(/^I initialize with (.*) and (.*)$/) do |channel, key|
  Zuppler.init channel, key
end

Then(/^Is initialized with (.*) and (.*)$/) do |channel, key|
  Zuppler.channel_key.should eq(channel)
  Zuppler.api_key.should eq(key)
  Zuppler.test?.should be_false
end

When(/^Zuppler is not initialized$/) do
  Zuppler.init '', ''
end
