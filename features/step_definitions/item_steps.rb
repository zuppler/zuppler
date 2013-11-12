When(/^I create item with "(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, price, size, priority|
  @item = Zuppler::Item.new :category => @category, :name => name, :price => price, :size => size,
  :priority => priority
  @item.save
end

Then(/^I should have item created$/) do
  @item.id.should_not be_nil
end

Given(/^I have an item "(.*?)"$/) do |id|
  @item = Zuppler::Item.new :category => @category, :id => id
end
