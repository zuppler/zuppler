When(/^I create item with "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, description, price, priority, size_name, size_priority|
  @item = Zuppler::Item.new category: @category, name: name, price: price,
  priority: priority, size_name: size_name, size_priority: size_priority,
  description: description
  @item.save
end

Then(/^I should have item created$/) do
  @item.id.should_not be_nil
end

Given(/^I have an item "(.*?)"$/) do |id|
  @item = Zuppler::Item.find id, 'demorestaurant'
end

When(/^I update item with "(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, description, price, priority|
  @item.name = name
  @item.description = description
  @item.price = price
  @item.priority = priority
  @item.image_url = 'http://s3.amazonaws.com/crunchbase_prod_assets/assets/images/resized/0016/4291/164291v2-max-250x250.png'
  @success = @item.save
end
When(/^I delete item$/) do
  @success = @item.destroy
end
