Given(/^I have an order "(.*?)"$/) do |uuid|
  @order = Zuppler::Order.find uuid
end

When(/^I fetch order details$/) do
  @order.totals
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


Then(/^I should have order accepted$/) do
  @success.should be_true
end
Then(/^I should have order details$/) do
  @order.customer.email.should eq('vinit100@gmail.com')
  @order.channel.name.should eq('Nalley Fresh')
  @order.restaurant.name.should eq('Nalley Fresh - Baltimore')

  @order.carts.first.items.first.name.should eq('Build Your Own... Nalley Salad')

  @order.totals.tax.should eq(48)
  @order.totals.total.should eq(848)
end
