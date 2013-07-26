require 'spec_helper'

describe Zuppler::Restaurant do
  
  it 'should create restaurant' do
    restaurant = Zuppler::Restaurant.get 'zuppler'
    restaurant['id'].should eq(1)
  end
  
end
