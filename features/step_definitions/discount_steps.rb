When(/^I create discount "(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, amount, min_order_amount, promo_code|
  @discount = Zuppler::Discount.new restaurant: @restaurant,
  name: name, amount: amount, min_order_amount: min_order_amount, promo_code: promo_code
  @discount.save
end
When(/^I update discount "(.*?)","(.*?)","(.*?)"$/) do |name, amount, min_order_amount|
  @discount.attributes = {
    name: name, amount: amount, min_order_amount: min_order_amount
  }
  @success = @discount.save
end
When(/^I delete discount$/) do
  @success = @discount.destroy
end

Then(/^I should have discount created$/) do
  expect(@discount.id).not_to be_nil
end

Given(/^I have a discount "(.*?)"$/) do |id|
  @discount = Zuppler::Discount.find id, 'demorestaurant'
end
