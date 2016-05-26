require 'spec_helper'

RSpec.describe Zuppler::Application do
  subject { Zuppler::Application.new 'ak', 'as' }

  it '#access_token' do
    url = 'http://users.biznettechnologies.com/oauth/token'
    body = { body: { client_id: 'ak', client_secret: 'as',
                     grant_type: 'client_credentials', scope: 'test' } }
    response = double(success?: true, '[]' => 'at')
    expect(HTTParty).to receive(:post).with(url, body).and_return response
    access_token = subject.access_token 'test'
    expect(access_token).to eq 'at'
  end
end
