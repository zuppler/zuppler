When(/^I create modifier "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, description, multiple, max_qty, priority|
  @modifier = Zuppler::Modifier.new restaurant: @restaurant, 
  name: name, description: description, priority: priority,
  multiple: multiple, max_qty: max_qty
  @modifier.save
end
When(/^I update modifier "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, multiple, min_qty, max_qty, priority|
  @modifier.attributes = {
    name: name, priority: priority,
    multiple: multiple, min_qty: min_qty, max_qty: max_qty
  }
  @success = @modifier.save
end
When(/^I delete modifier$/) do
  @success = @modifier.destroy
end

Then(/^I should have modifier created$/) do
  expect(@modifier.id).not_to be_nil
end

Given(/^I have a modifier "(.*?)"$/) do |id|
  @modifier = Zuppler::Modifier.find id, 'demorestaurant'
end

