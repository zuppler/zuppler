When(/^I create modifier "(.*?)", "(.*?)", "(.*?), "(.*?)"$/) do |name, price, size, priority|
  @modifier = Zuppler::Modifier.new :choice => @choice, :name => name, :price => price, 
  :size => size, :priority => priority
  @modifier.save
end

Then(/^I should have modifier created$/) do
  @modifier.id.should_not be_nil
  @modifier.parent_id.should_not be_nil
end


