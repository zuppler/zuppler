require 'httparty'

require "zuppler/version"
require "zuppler/channel"
require "zuppler/restaurant"

module Zuppler

  class << self
    attr_reader :channel, :api_key, :test

    def init(channel, api_key, test = false)
      self.channel, self.api_key, self.test = channel, api_key, test
    end
    
    def api_host
      'http://api.zuppler.com'
    end
    def api_version
      '/v2'
    end
    def api_url
      api_host + api_version
    end
    
    def test?
      !!test
    end
private
    attr_writer :channel, :api_key, :test
  end

end
