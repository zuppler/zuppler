require 'active_model'
require 'active_attr'
require 'httparty'

require "zuppler/version"
require "zuppler/model"
require "zuppler/channel"
require "zuppler/restaurant"
require "zuppler/menu"

module Zuppler
  class Error < RuntimeError
  end

  class << self
    attr_reader :channel_key, :api_key, :test

    def init(channel_key, api_key, test = false)
      self.channel_key, self.api_key, self.test = channel_key, api_key, test
    end
    def check
      raise Zuppler::Error.new(':channel_key cannot be blank') if channel_key.blank?
      raise Zuppler::Error.new(':api_key cannot be blank') if api_key.blank?
    end
    
    def api_host
#      test? ? 'http://api.biznettechnologies.com' : 'http://api.zuppler.com'
      test? ? 'http://api.zuppler.dev' : 'http://api.zuppler.com'
    end
    def api_version
      '/v2'
    end
    def channels_uri
      "/channels/#{channel_key}"
    end
    def api_url
      api_host + api_version + channels_uri
    end
    
    def test?
      !!test
    end

    def channel
      @channel ||= Zuppler::Channel.find channel_key
    end

    private
    attr_writer :channel_key, :api_key, :test
  end
end
