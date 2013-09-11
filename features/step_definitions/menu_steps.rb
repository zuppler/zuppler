Given(/^I have a restaurant with "(.*?)","(.*?)"$/) do |id, permalink|
  @restaurant = Zuppler::Restaurant.new :id => 1, :permalink => 'demorestaurant'
end

When(/^I create menu "(.*?)"$/) do |name|
  @menu = Zuppler::Menu.new :restaurant => @restaurant, :name => name
  @menu.save
end

Then(/^I should have menu created$/) do
  @menu.id.should_not be_nil
end
