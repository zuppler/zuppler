Then(/^Restaurants should raise error$/) do
  expect { Zuppler::Restaurant.all }.to raise_error
  expect { Zuppler::Restaurant.create }.to raise_error
end



Given(/^Zuppler configured with (.*) and (.*)$/) do |channel, key|
  Zuppler.init channel, key, true
end
When(/^I create (.*),(.*),(.*),(.*),(.*),(.*),(.*) restaurant$/) do |name,rid,logo,location,oname,oemail,ophone|
  restaurant = Zuppler::Restaurant.create do |r| 
    r.name, r.rid, r.logo, r.location = name, rid, logo, location
    r.owner = {:name => oname, :email => oemail, :phone => ophone}
  end
end
Then(/^I should have (.*) in channel$/) do |permalink|
  Zuppler::Restaurant.all.to_s.should include(permalink)
end


