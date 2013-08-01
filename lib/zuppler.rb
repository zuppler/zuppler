require 'httparty'

require "zuppler/version"
require "zuppler/channel"
require "zuppler/restaurant"

module Zuppler
  class << self
    attr_accessor :channel, :api_key, :test

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
  end
end
