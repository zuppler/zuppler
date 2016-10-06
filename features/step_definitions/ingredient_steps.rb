When(/^I create ingredient "(.*?)","(.*?)","(.*?)","(.*?)","(.*?)"$/) do |name, description, price, size, priority|
  @ingredient = Zuppler::Ingredient.new choice: @choice, name: name, price: price,
                                        size: size, priority: priority, description: description,
                                        default: true
  @ingredient.save do |success, response|
    expect(success).to be_truthy
    json = response.parsed_response.symbolize_keys
    expect(json).to include success: true
    expect(json[:modifier].symbolize_keys).to include name: name
  end
end

When(/^I update ingredient "(.*?)" with "(.*?)","(.*?)","(.*?)","(.*?)"$/) do |_id, name, price, priority, _active|
  @ingredient.attributes = {
    name: name, price: price, priority: priority, default: true, description: 'up up',
    option_id: nil
  }
  @ingredient.choice = @choice
  @success = @ingredient.save
end

When(/^I delete ingredient$/) do
  @success = @ingredient.destroy
end

Then(/^I should have ingredient created$/) do
  expect(@ingredient.id).not_to be_nil
  expect(@ingredient.parent_id).not_to be_nil
end

Given(/^I have a ingredient "(.*?)"$/) do |id|
  @ingredient = Zuppler::Ingredient.find id, 'demorestaurant'
end
