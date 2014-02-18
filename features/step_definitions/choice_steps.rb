When(/^I create choice "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, description, multiple, max_qty, priority, order_by_priority|
  @choice = Zuppler::Choice.new category: @category, name: name, multiple: multiple, max_qty: max_qty, priority: priority, order_by_priority: order_by_priority, description: description
  @choice.save
end
When(/^I update choice "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, priority, active, multiple, min_qty, max_qty|
  @choice.attributes = {
    name: name, priority: priority, active: active,
    multiple: multiple, min_qty: min_qty, max_qty: max_qty
  }
  @success = @choice.save
end
When(/^I delete choice$/) do
  @success = @choice.destroy
end

Then(/^I should have choice created$/) do
  @choice.id.should_not be_nil
end

Given(/^I have a choice "(.*?)"$/) do |id|
  @choice = Zuppler::Choice.new category: @category, id: id
end

