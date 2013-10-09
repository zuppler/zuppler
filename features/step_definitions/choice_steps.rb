When(/^I create choice "(.*?)"$/) do |name|
  @choice = Zuppler::Choice.new :category => @category, :name => name
  @choice.save
end

Then(/^I should have choice created$/) do
  @choice.id.should_not be_nil
end

Given(/^I have a choice "(.*?)"$/) do |id|
  @choice = Zuppler::Choice.new :category => @category, :id => id
end

