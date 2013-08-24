require 'spec_helper'

describe Zuppler::Restaurant do
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:remote_id) }
  it { should validate_presence_of(:logo) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:owner) }

  it 'returns name attributes' do
    restaurant = Zuppler::Restaurant.new :name => 'name'
    restaurant.attributes.should include({:name => 'name'})
  end
  
end
