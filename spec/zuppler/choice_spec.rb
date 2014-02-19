require "spec_helper"

describe Zuppler::Choice do
  describe '#find' do
    it 'finds with restaurant_id' do
      choice = Zuppler::Choice.find 1, 1
      choice.restaurant_id.should eq(1)
    end
  end
end
