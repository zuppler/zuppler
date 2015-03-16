require 'spec_helper'

describe 'Zuppler::Model' do
  it 'should wrap create' do
    class R
      def self.create(_options = {})
        'create'
      end
      include Zuppler::Macros
    end
    Zuppler.should_receive(:check)
    R.create.should eq('create')
  end
end
