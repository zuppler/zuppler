Given(/^I have an order "(.*?)"$/) do |uuid|
  @order = Zuppler::Order.find uuid
end

When(/^I confirm order$/) do
  @success = @order.confirm
end
When(/^I reject order$/) do
  @success = @order.reject
end  


Then(/^I should have order confirmed$/) do
  @success.should be_true
end
Then(/^I should have order rejected$/) do
  @success.should be_true
end
