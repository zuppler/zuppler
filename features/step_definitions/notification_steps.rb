When(/^I execute "(.*?)" notification$/) do |type|
  notification = @order.notification type
  @success = notification.execute sender: 'cucumber'
end
When(/^I confirm "(.*?)" notification$/) do |type|
  notification = @order.notification type
  @success = notification.confirm sender: 'cucumber'
end

Then(/^I should have notification accepted$/) do
  expect(@success).to be_truthy
end
