Given(/^I have an order "(.*?)"$/) do |uuid|
  @order = Zuppler::Order.find uuid
end

When(/^I fetch order details$/) do
  @order.details
end

When(/^I confirm order$/) do
  @success = @order.confirm time: '2014-03-18 17:45', duration: 20
end
When(/^I cancel order$/) do
  @success = @order.cancel reason: 'food was cold'
end
When(/^I miss order$/) do
  @success = @order.miss
end
When(/^I open order$/) do
  @response = @order.open reason: 'out of fish'
end
When(/^I close order$/) do
  @response = @order.close
end
When(/^I touch order$/) do
  @success = @order.touch
end

Then(/^I should have order accepted$/) do
  @success.should be_truthy
end
Then(/^I get hash response$/) do
  @response.should include('success' => false)
end
Then(/^I should have order details$/) do
  @order.details.customer.email.should eq('vinit100@gmail.com')
  @order.details.channel.name.should eq('Nalley Fresh')
  @order.details.restaurant.name.should eq('Nalley Fresh - Baltimore')

  @order.details.carts.first.items.first.name.should eq('Build Your Own... Nalley Salad')

  @order.details.totals.tax.should eq(48)
  @order.details.totals.total.should eq(848)

  @order.details.time.id.should eq('SCHEDULE')
  @order.details.time.value.should eq('2014-04-10 11:40 -0400')
end
