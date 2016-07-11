# require 'spec_helper'

# describe Zuppler::Order do
#   describe '#details' do
#     it 'retries and succeed' do
#       order = Zuppler::Order.find '1234'
#       response1 = Hashie::Mash.new success?: false, status: { code: 501 }
#       response2 = Hashie::Mash.new success?: true, success: true, status: { code: 200 }
#       expect(order).to receive(:get).exactly(3).times.and_return(response1, response1, response2)
#       order.details
#     end

#     # it 'retries max 3 times' do
#     #   order = Zuppler::Order.find '1234'
#     #   response = Hashie::Mash.new success?: false, status: { code: 501 }
#     #   expect(order).to receive(:execute_get).once.and_return response
#     #   expect(order.details).to be(nil)
#     # end

#     # it 'never retry on server error' do
#     #   order = Zuppler::Order.find '1234'
#     #   response = Hashie::Mash.new success?: false, status: { code: 404 }
#     #   expect(order).to receive(:execute_get).once.and_raise Zuppler::ServerError
#     #   order.details
#     # end
#   end
# end
