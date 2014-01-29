When(/^I create category with "(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name,desc,priority,priced_by_size|
  @category = Zuppler::Category.new name: name, menu: @menu, description: desc, 
  priority: priority, priced_by_size: priced_by_size
  @category.save
end

Then(/^I should have category created$/) do
  @category.id.should_not be_nil
end

Given(/^I have a category "(.*?)"$/) do |id|
  @category = Zuppler::Category.new :menu => @menu, :id => id
end


