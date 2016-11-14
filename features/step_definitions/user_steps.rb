#
# Whens
#
When(/^I initialize user with "([^"]*)"$/) do |access_token|
  @user = Zuppler::User.find access_token, 'current'
end

When(/^I search users by role "(.*)"$/) do |role|
  @response = Zuppler::User.search @access_token, role: role
end

When(/^I update access grant$/) do
  expect do
    @user.details
  end.not_to raise_error
  @result = @user.grant(@user.id, market: [1])
end

When(/^I get user providers$/) do
  @providers = @user.providers
end

When(/^I get user vaults$/) do
  @vaults = @user.vaults
end

When(/^I create vaults$/) do
  @success = @user.create_vault name: 'test', brand: 'visa', number: '1234',
                                expiration_date: '11/2016', uid: 'abcd'
end

#
# Thens
#
Then(/^I have user details$/) do
  expect(@user.details.name).to eq 'Test Account'
  expect(@user.details.email).to eq 'test@zuppler.com'
  expect(@user.details.phone).to eq '1234567890'
end

Then(/^I am not authorized$/) do
  expect do
    @user.details
  end.to raise_error(Zuppler::NotAuthorized)
end

Then(/I receive not enough roles$/) do
  expect(@result).not_to be true
end

Then(/I receive success grant$/) do
  expect(@result).to be true
end

Then(/^I receive ambassador users$/) do
  expect(@response.pagination['total']).to be > 40
  expect(@response.users.size).to eq 10
  @response.users.each do |u|
    expect(u.roles).to include 'ambassador'
  end
end

Then(/^I receive user providers$/) do
  expect(@providers.size).to be > 1
  expect(@providers.select { |p| p.provider == 'zuppler' }.size).to eq 1
end

Then(/^I receive user vaults$/) do
  expect(@vaults.size).to eq 0
end

Then(/^vault is created$/) do
  expect(@success).to be_truthy
end
