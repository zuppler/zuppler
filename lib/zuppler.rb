require 'active_model'
require 'active_attr'
require 'httparty'
require 'multi_json'
require 'hashie'

require 'zuppler/version'
require 'zuppler/model'

require 'zuppler/channel'
require 'zuppler/restaurant'
require 'zuppler/menu'
require 'zuppler/category'
require 'zuppler/item'
require 'zuppler/choice'
require 'zuppler/ingredient'
require 'zuppler/modifier'
require 'zuppler/option'

require 'zuppler/order'
require 'zuppler/notification'
require 'zuppler/discount'

module Zuppler
  class Error < RuntimeError
  end

  class << self
    attr_accessor :channel_key, :restaurant_key, :api_key, :test, :domain

    def init(channel_key, api_key, test = true)
      self.channel_key, self.api_key, self.test = channel_key, api_key, test
    end

    def configure
      yield self
    end
    alias :config :configure

    def check
      fail Zuppler::Error, ':channel_key cannot be blank' if channel_key.blank?
      fail Zuppler::Error, ':api_key cannot be blank' if api_key.blank?
    end

    PRODUCTION_DOMAIN = 'zuppler.com'
    STAGING_DOMAIN = 'biznettechnologies.com'
    def api_domain
      if domain.blank?
        test? ? STAGING_DOMAIN : PRODUCTION_DOMAIN
      else
        domain
      end
    end

    def api_version
      '/v2'
    end

    def channels_uri
      "/channels/#{channel_key}"
    end

    def api_url(version = 'v2')
      'http://api.' + api_domain + "/#{version}" + channels_uri
    end

    def secure_url(version = 'v4')
      'http://secure.' + api_domain + "/#{version}"
    end

    def restaurants_api_url(version = 'v4')
      'http://api.' + api_domain + "/#{version}"
    end

    def orders_api_url(version = 'v4')
      'http://orders.api.' + api_domain + "/#{version}"
    end

    def test?
      !!test
    end

    def channel
      @channel ||= Zuppler::Channel.find channel_key
    end
  end
end
