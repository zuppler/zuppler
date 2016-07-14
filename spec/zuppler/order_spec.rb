require 'spec_helper'

describe Zuppler::Order do
  describe '#details' do
    it 'retries 3 times and succeed' do
      order = Zuppler::Order.find '1234'
      response1 = Hashie::Mash.new success?: false, status: { code: 501 }
      response2 = Hashie::Mash.new success?: true, success: true, status: { code: 200 }
      expect(Zuppler::Model).to receive(:get).exactly(3).times.and_return(response1, response1, response2)
      order.details
    end

    it 'does not retry if response success' do
      order = Zuppler::Order.find '1234'
      response = Hashie::Mash.new success?: true, success: true, status: { code: 200 }
      expect(Zuppler::Model).to receive(:get).once.and_return(response)
      expect(order.details).to be_an_instance_of(Hashie::Mash)
    end
  end
end
