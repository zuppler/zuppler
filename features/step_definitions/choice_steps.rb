When(/^I create choice "(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, multiple, max_qty, priority|
  @choice = Zuppler::Choice.new :category => @category, :name => name, :multiple => multiple, :max_qty => max_qty, :priority => priority
  @choice.save
end

Then(/^I should have choice created$/) do
  @choice.id.should_not be_nil
end

Given(/^I have a choice "(.*?)"$/) do |id|
  @choice = Zuppler::Choice.new :category => @category, :id => id
end

