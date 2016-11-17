require 'spec_helper'

RSpec.describe Zuppler::User do
  describe '.from_omniauth' do
    it 'gets attributes', :vcr do
      omniauth = {
        'info' => { 'id' => '1', 'name' => 'n',
                    'email' => 'a@b.c', 'phone' => '1234',
                    'roles' => %w(admin config), 'acls' => { 'delivery_service' => [1, 2] }
                  },
        'extra' => { 'provider' => 'p' },
        'credentials' => { 'token' => 'at' }
      }
      zu = Zuppler::User.from_omniauth omniauth
      expect(zu.id).to eq '1'
      expect(zu.name).to eq 'n'
      expect(zu.email).to eq 'a@b.c'
      expect(zu.phone).to eq '1234'
      expect(zu.provider).to eq 'p'
      expect(zu.access_token).to eq 'at'
      expect(zu.roles).to eq %w(admin config)
    end
  end

  describe '#details' do
    # Hash cache executes the block every time
    # it 'cache hit' do
    #   zu = Zuppler::User.find 'at'
    #   expect(zu).to receive(:execute_get).once.and_return user: { name: 'test' }, success: true
    #   expect(zu).to receive(:v4_success?).once.and_return true
    #   zu.details
    #   zu.details
    # end
    it 'cache miss' do
      zu = Zuppler::User.find 'at'
      expect(zu).to receive(:execute_get).twice.and_return user: {}, success: true
      expect(zu).to receive(:v4_success?).twice.and_return false
      zu.details
      zu.details
    end
  end
end
