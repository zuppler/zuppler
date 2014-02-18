When(/^I create modifier "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, description, price, size, priority|
  @modifier = Zuppler::Modifier.new choice: @choice, name: name, price: price, 
  size: size, priority: priority, description: description
  @modifier.save
end

When(/^I update modifier "(.*?)" with "(.*?)","(.*?)","(.*?)","(.*?)"$/) do |id, name, price, priority,active|
  @modifier = Zuppler::Modifier.find id, @choice
  @modifier.attributes = {name: name, price: price, priority: priority}
  @success = @modifier.save
end

When(/^I delete modifier$/) do
  @success = @modifier.destroy
end

Then(/^I should have modifier created$/) do
  @modifier.id.should_not be_nil
  @modifier.parent_id.should_not be_nil
end

Given(/^I have a modifier "(.*?)"$/) do |id|
  @modifier = Zuppler::Modifier.find id, @choice
end
