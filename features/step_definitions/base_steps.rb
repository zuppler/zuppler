Then(/^I should get success response$/) do
  expect(@success).to be_truthy
end
Then(/^I should get failed response$/) do
  expect(@success).to be_falsy
end
