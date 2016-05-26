require 'spec_helper'

describe Zuppler::Channel do
  it 'should get channel', :vcr do
    Zuppler.init 'zuppler', ''
    channel = Zuppler::Channel.find 'zuppler'
    expect(channel['id']).to eq(1)
    expect(channel['name']).to eq('Zuppler')
    expect(channel['permalink']).to eq('zuppler')
    expect(channel['logo']).not_to be_nil
  end
end
