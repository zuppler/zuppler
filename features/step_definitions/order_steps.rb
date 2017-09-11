Given(/^I have an order "(.*?)"$/) do |uuid|
  @order = Zuppler::Order.find uuid
end

When(/^I fetch order details$/) do
  @order.details
end

When(/^I confirm order$/) do
  @success = @order.confirm time: '2016-07-12 11:23', duration: 20, sender: 'test'
end
When(/^I cancel order$/) do
  @success = @order.cancel reason: 'food was cold', sender: 'test'
end
When(/^I miss order$/) do
  @success = @order.miss sender: 'test', force: true
end
When(/^I open order$/) do
  @response = @order.open reason: 'out of fish', sender: 'test'
end
When(/^I close order$/) do
  @response = @order.close sender: 'test'
end
When(/^I touch order$/) do
  @success = @order.touch sender: 'test'
end
When(/^I update order$/) do
  @success = @order.save metadata: { rds: { market_id: 12 } }
end

Then(/^I should have order accepted$/) do
  @success.should be_truthy
end
Then(/^I get hash response$/) do
  @response.should include('success' => false)
end
Then(/^I should have order details$/) do
  @order.details.channel.name.should eq('Nalley Fresh')
  @order.details.restaurant.name.should eq('Nalley Fresh - Baltimore')

  @order.details.carts.first.items.first.name.should eq('Build Your Own... Nalley Salad')

  @order.details.totals.tax.should eq(48)
  @order.details.totals.total.should eq(848)

  @order.details.time.id.should eq('SCHEDULE')
  @order.details.time.value.should eq('2014-04-10T11:40:00-04:00')
end
