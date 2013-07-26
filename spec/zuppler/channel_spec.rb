require "spec_helper"

describe Zuppler::Channel do

  it 'should get channel', :vcr do
    channel = Zuppler::Channel.find 'zuppler'
    channel['id'].should eq(1)
    channel['name'].should eq('Zuppler')
    channel['permalink'].should eq('zuppler')
    channel['logo'].should_not be_nil
  end
  
end
