When(/^I create menu "(.*?)"$/) do |name|
  @menu = Zuppler::Menu.new :restaurant => @restaurant, :name => name
  @menu.save
end

Then(/^I should have menu created$/) do
  @menu.id.should_not be_nil
end

Given(/^I have a menu "(.*?)"$/) do |id|
  @menu = Zuppler::Menu.new :id => id, :restaurant => @restaurant
end

