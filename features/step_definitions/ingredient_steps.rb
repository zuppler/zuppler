When(/^I create ingredient "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, description, price, size, priority|
  @ingredient = Zuppler::Ingredient.new choice: @choice, name: name, price: price,
                                        size: size, priority: priority, description: description
  @ingredient.save
end

When(/^I update ingredient "(.*?)" with "(.*?)","(.*?)","(.*?)","(.*?)"$/) do |_id, name, price, priority, _active|
  @ingredient.attributes = { name: name, price: price, priority: priority, option_id: 1 }
  @success = @ingredient.save
end

When(/^I delete ingredient$/) do
  @success = @ingredient.destroy
end

Then(/^I should have ingredient created$/) do
  @ingredient.id.should_not be_nil
  @ingredient.parent_id.should_not be_nil
end

Given(/^I have a ingredient "(.*?)"$/) do |id|
  @ingredient = Zuppler::Ingredient.find id, 'demorestaurant'
end
