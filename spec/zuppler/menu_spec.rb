require 'spec_helper'
require 'active_attr/rspec'

describe Zuppler::Menu do
  it { should validate_presence_of(:restaurant) }
  it { should validate_presence_of(:name) }

  it 'validates restaurant' do
    subject.name = 'lunch'
    subject.restaurant = Zuppler::Restaurant.new
    subject.valid?.should be_false
    subject.errors[:restaurant].should eql(['permalink is required'])
  end
end
