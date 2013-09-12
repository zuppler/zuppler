Given(/^I have a menu "(.*?)"$/) do |id|
  @menu = Zuppler::Menu.new :id => id, :restaurant => @restaurant
end

When(/^I create category with "(.*?)"$/) do |name|
  @category = Zuppler::Category.new :name => name, :menu => @menu
  @category.save
end

Then(/^I should have category created$/) do
  @category.id.should_not be_nil
end
