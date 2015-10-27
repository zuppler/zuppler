When(/^I create category with "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, desc, priority, min_qty, priced_by_size|
  @category = Zuppler::Category.new name: name, menu: @menu, description: desc,
                                    min_qty: min_qty, priority: priority,
                                    priced_by_size: priced_by_size
  @category.save
end
When(/^I update category with "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, description, active, priority, min_qty|
  @category.attributes = {
    name: name, description: description, active: active,
    priority: priority, min_qty: min_qty
  }
  @category.menu = @menu
  @success = @category.save
end
When(/^I delete category$/) do
  @success = @category.destroy
end

Then(/^I should have category created$/) do
  expect(@category.id).not_to be_nil
end

Given(/^I have a category "(.*?)"$/) do |id|
  @category = Zuppler::Category.find id, 'demorestaurant'
end
