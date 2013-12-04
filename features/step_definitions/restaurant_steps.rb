Given(/^I have a restaurant "(.*?)","(.*?)"$/) do |id, permalink|
  @restaurant = Zuppler::Restaurant.new :id => id, :permalink => 'demorestaurant'
end



When(/^I create (.*),(.*),(.*),(.*),(.*),(.*),(.*) restaurant$/) do |name,rid,logo,location,oname,oemail,ophone|
  company = Faker::Company.name
  name = "#{name} - #{company}"
  rid = "#{rid} - #{company}"
  options = {
    :name => name, :remote_id => rid, :logo => logo, :location => location,
    :owner => {:name => oname, :email => oemail, :phone => ophone}
  }
  @restaurant = Zuppler::Restaurant.create options
end
When(/^I find restaurant "(.*?)"$/) do |permalink|
  @restaurant = Zuppler::Restaurant.find permalink
end



Then(/^I should have (.*) restaurant$/) do |permalink|
  @restaurant.id.should_not be_nil
  @restaurant.permalink.should_not be_nil
end
Then(/^Restaurants should raise error$/) do
  expect { Zuppler::Restaurant.create }.to raise_error(Zuppler::Error)
end

