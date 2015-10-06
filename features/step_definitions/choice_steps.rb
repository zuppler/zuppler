When(/^I create choice "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, description, multiple, max_qty, priority, order_by_priority, multiple_ingredients|
  @choice = Zuppler::Choice.new category: @category, name: name, multiple: multiple, max_qty: max_qty,
                                priority: priority, order_by_priority: order_by_priority, description: description,
                                multiple_ingredients: multiple_ingredients
  @choice.save
end
When(/^I update choice "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, priority, active, multiple, min_qty, max_qty, multiple_ingredients|
  @choice.attributes = {
    name: name, priority: priority, active: active,
    multiple: multiple, min_qty: min_qty, max_qty: max_qty,
    modifier_id: 1, multiple_ingredients: multiple_ingredients
  }
  @success = @choice.save
end
When(/^I delete choice$/) do
  @success = @choice.destroy
end

Then(/^I should have choice created$/) do
  expect(@choice.id).not_to be_nil
end

Given(/^I have a choice "(.*?)"$/) do |id|
  @choice = Zuppler::Choice.find id, 'demorestaurant'
end
