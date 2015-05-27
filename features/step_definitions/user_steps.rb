When(/^I initialize user with "([^"]*)"$/) do |access_token|
  @user = Zuppler::User.find access_token
end

Then(/^I should have user details$/) do
  expect(@user.details.name).to eq 'Test Account'
  expect(@user.details.email).to eq 'test@zuppler.com'
  expect(@user.details.phone).to eq '610 999 3803'
end

Then(/^I am not authorized$/) do
  expect do
    @user.details
  end.to raise_error(Zuppler::NotAuthorized)
end
