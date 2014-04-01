Given(/^I have a restaurant "(.*?)","(.*?)"$/) do |id, permalink|
  @restaurant = Zuppler::Restaurant.new :id => id, :permalink => 'demorestaurant'
end


When(/^I create "(.*?)", "(.*?)" restaurant$/) do |name, address|
  company = Faker::Company.name
  name = "#{name} - #{company}"
  @restaurant = Zuppler::Restaurant.create name: name, address: address
end
When(/^I find restaurant "(.*?)"$/) do |permalink|
  @restaurant = Zuppler::Restaurant.find permalink
end
When(/^I publish restaurant "(.*?)"$/) do |permalink|
  @restaurant = Zuppler::Restaurant.find permalink
  @success = @restaurant.publish
end


Then(/^I should have "(.*)" restaurant$/) do |permalink|
  @restaurant.id.should_not be_nil
  @restaurant.permalink.should_not be_nil
end
Then(/^Restaurants should raise error$/) do
  expect { Zuppler::Restaurant.create }.to raise_error(Zuppler::Error)
end

