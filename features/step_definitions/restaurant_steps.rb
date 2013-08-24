Then(/^Restaurants should raise error$/) do
  expect { Zuppler::Restaurant.create }.to raise_error(Zuppler::Error)
end

Given(/^Zuppler configured with (.*) and (.*)$/) do |channel, key|
  Zuppler.init channel, key, true
end
When(/^I create (.*),(.*),(.*),(.*),(.*),(.*),(.*) restaurant$/) do |name,rid,logo,location,oname,oemail,ophone|
  @restaurant = Zuppler::Restaurant.create do |r| 
    r.name, r.remote_id, r.logo, r.location = name, rid, logo, location
    r.owner = {:name => oname, :email => oemail, :phone => ophone}
  end
end
Then(/^I should have (.*) restaurant created$/) do |permalink|
  @restaurant.should be
  @restaurant.id.should be
end

Then(/^I should have (\d+) restaurants$/) do |count|
  Zuppler::Restaurant.all.size.should count
end



