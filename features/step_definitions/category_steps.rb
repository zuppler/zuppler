When(/^I create category with "(.*?)"$/) do |name|
  @category = Zuppler::Category.new :name => name, :menu => @menu
  @category.save
end

Then(/^I should have category created$/) do
  @category.id.should_not be_nil
end

Given(/^I have a category "(.*?)"$/) do |id|
  @category = Zuppler::Category.new :menu => @menu, :id => id
end


