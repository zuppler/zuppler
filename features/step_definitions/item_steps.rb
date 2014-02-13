When(/^I create item with "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, price, priority, size_name, size_priority|
  @item = Zuppler::Item.new category: @category, name: name, price: price,
  priority: priority, size_name: size_name, size_priority: size_priority
  @item.save
end

Then(/^I should have item created$/) do
  @item.id.should_not be_nil
end

Given(/^I have an item "(.*?)"$/) do |id|
  @item = Zuppler::Item.new :category => @category, :id => id
end

When(/^I update item "(.*?)" with "(.*?)","(.*?)","(.*?)"$/) do |id, name, price, priority|
  @item = Zuppler::Item.find id, @category
  @item.name = name
  @item.price = price
  @item.priority = priority
  @success = @item.save
end
When(/^I delete item$/) do
  @success = @item.destroy
end
