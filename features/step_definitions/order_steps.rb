Given(/^I have an order "(.*?)"$/) do |uuid|
  @order = Zuppler::Order.find uuid
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
