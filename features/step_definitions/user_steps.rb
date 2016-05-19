When(/^I initialize user with "([^"]*)"$/) do |access_token|
  @user = Zuppler::User.find access_token, 'current'
end

Then(/^I should have user details$/) do
  expect(@user.details.name).to eq 'Test Account'
  expect(@user.details.email).to eq 'test@zuppler.com'
  expect(@user.details.phone).to eq '1234567890'
end

Then(/^I am not authorized$/) do
  expect do
    @user.details
  end.to raise_error(Zuppler::NotAuthorized)
end

When(/^I update access grant$/) do
  expect do
    @user.details
  end.not_to raise_error
  @result = @user.grant(@user.id, market: [1])
end

Then(/I should receive not enough roles$/) do
  expect(@result).not_to be true
end

Then(/I should receive success grant$/) do
  expect(@result).to be true
end
