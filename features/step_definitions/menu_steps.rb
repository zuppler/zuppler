When(/^I create menu "(.*?)","(.*?)","(.*?)"$/) do |name, description, priority|
  @menu = Zuppler::Menu.new restaurant: @restaurant, name: name,
                            priority: priority, description: description
  @menu.save
end

When(/^I update menu with "(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, description, active, priority|
  @menu.attributes = {
    name: name, description: description, active: active, priority: priority
  }
  @success = @menu.save
end

When(/^I delete menu$/) do
  @success = @menu.destroy
end

Then(/^I should have menu created$/) do
  @menu.id.should_not be_nil
end

Given(/^I have a menu "(.*?)"$/) do |id|
  @menu = Zuppler::Menu.new id: id, restaurant: @restaurant
end
