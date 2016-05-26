require 'spec_helper'

describe Zuppler::Order do
  describe '#details' do
    it 'retries and succeed' do
      order = Zuppler::Order.find '1234'
      response1 = Hashie::Mash.new success?: false, status: { code: 501 }
      response2 = Hashie::Mash.new success?: true, success: true, status: { code: 200 }
      expect(order).to receive(:execute_get).twice.and_return response1, response2
      order.details
    end

    it 'retries max 3 times' do
      order = Zuppler::Order.find '1234'
      response = Hashie::Mash.new success?: false, status: { code: 501 }
      expect(order).to receive(:execute_get).exactly(3).times.and_return response
      expect do
        order.details
      end.to raise_error Zuppler::RetryError
    end

    it 'never retry on server error' do
      order = Zuppler::Order.find '1234'
      response = Hashie::Mash.new success?: false, status: { code: 500 }
      expect(order).to receive(:execute_get).once.and_return response
      expect do
        order.details
      end.to raise_error Zuppler::ServerError
    end
  end
end
