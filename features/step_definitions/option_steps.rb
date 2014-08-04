When(/^I create option "(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, description, price, priority|
  @option = Zuppler::Option.new modifier: @modifier, name: name, 
  description: description, price: price, priority: priority
  @option.save
end

When(/^I update option with "(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, price, priority, active|
  @option.attributes = {name: name, price: price, priority: priority}
  @success = @option.save
end

When(/^I delete option$/) do
  @success = @option.destroy
end

Then(/^I should have option created$/) do
  expect(@option.id).not_to be_nil
end

Given(/^I have an option "(.*?)"$/) do |id|
  @option = Zuppler::Option.find id, 'demorestaurant'
end
