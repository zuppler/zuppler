Given(/^I have a restaurant "(.*?)","(.*?)"$/) do |id, _permalink|
  @restaurant = Zuppler::Restaurant.new id: id, permalink: 'demorestaurant'
end

When(/^I create "(.*?)", "(.*?)" restaurant$/) do |name, address|
  company = Faker::Company.name
  name = "#{name} - #{company}"
  @restaurant = Zuppler::Restaurant.create name: name, address: address
end
When(/^I find restaurant "(.*?)"$/) do |permalink|
  @restaurant = Zuppler::Restaurant.find permalink
end
When(/^I update restaurant "(.*?)" with "(.*?)"$/) do |permalink, name|
  @restaurant = Zuppler::Restaurant.find permalink
  @restaurant.name = name
  @restaurant.save
end
When(/^I publish restaurant "(.*?)"$/) do |permalink|
  @restaurant = Zuppler::Restaurant.find permalink
  @success = @restaurant.publish
end
When(/^I pause restaurant "(.*?)"$/) do |permalink|
  @restaurant = Zuppler::Restaurant.find permalink
  @success = @restaurant.pause
end
When(/^I resume restaurant "(.*?)"$/) do |permalink|
  @restaurant = Zuppler::Restaurant.find permalink
  @success = @restaurant.resume
end
When(/^I fetch restaurant details$/) do
  @restaurant.details
end

Then(/^I should have "(.*)" restaurant$/) do |_permalink|
  @restaurant.permalink.should_not be_nil
end
Then(/^Restaurants should raise error$/) do
  expect { Zuppler::Restaurant.create }.to raise_error(Zuppler::Error)
end
Then(/^I should have restaurant details$/) do
  expect(@restaurant.details['id']).to eq(242)
  expect(@restaurant.details['permalink']).to eq('demorestaurant')
  expect(@restaurant.details['timezone']['name']).to match('Eastern')
  expect(@restaurant.details['locations'].size).to eq(1)
  expect(@restaurant.details['discounts'].size).to be > 1
  expect(@restaurant.details['events'].size).to be > 1

  expect(@restaurant.details['configuration']['payments']['cash']).to be_truthy
  expect(@restaurant.details['configuration']['delivery']['contact']['name']).to eq('demo')
end
