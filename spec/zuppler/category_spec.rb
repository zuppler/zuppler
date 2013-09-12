require "spec_helper"

describe Zuppler::Category do
  it { should validate_presence_of(:menu) }
  it { should validate_presence_of(:name) }

  it 'validates menu' do
    subject.name = 'pizzas'
    subject.menu = Zuppler::Menu.new
    subject.valid?.should be_false
    subject.errors[:menu].should eql(['id is missing'])
  end
end
