When(/^I create item with "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, description, price, priority, size_name, size_priority, min_qty|
  @item = Zuppler::Item.new category: @category, name: name, price: price,
                            priority: priority, size_name: size_name, size_priority: size_priority,
                            description: description, min_qty: min_qty
  @item.save
end

Then(/^I should have item created$/) do
  expect(@item.id).not_to be_nil
end

Given(/^I have an item "(.*?)"$/) do |id|
  @item = Zuppler::Item.find id, 'demorestaurant'
end

When(/^I update item with "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, description, price, priority, min_qty|
  @item.category = @category
  @item.name = name
  @item.description = description
  @item.price = price
  @item.priority = priority
  @item.image_url = 'http://s3.amazonaws.com/crunchbase_prod_assets/assets/images/resized/0016/4291/164291v2-max-250x250.png'
  @item.min_qty = min_qty
  @success = @item.save
end
When(/^I delete item$/) do
  @success = @item.destroy
end
