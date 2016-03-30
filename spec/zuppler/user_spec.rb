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
end
