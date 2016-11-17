require 'zuppler/users/search'
require 'zuppler/users/acls'
require 'zuppler/users/vaults'
require 'zuppler/users/providers'
require 'zuppler/users/zupps'
require 'zuppler/users/roles'
require 'zuppler/users/prints'

module Zuppler
  class User < Model
    include ActiveAttr::Model
    include Zuppler::Requestable
    include Zuppler::Users::Acls, Zuppler::Users::Roles,
            Zuppler::Users::Vaults, Zuppler::Users::Providers,
            Zuppler::Users::Zupps, Zuppler::Users::Prints
    extend Zuppler::Users::Search

    attribute :id
    attribute :name
    attribute :email
    attribute :phone
    attribute :roles
    attribute :access_token
    attribute :provider

    def self.find(access_token, id = 'current')
      Zuppler::User.new access_token: access_token, id: id
    end

    def self.from_omniauth(omniauth)
      info = omniauth['info']
      extra = omniauth['extra']
      credentials = omniauth['credentials']
      Zuppler::User.new id: info['id'], name: info['name'],
                        email: info['email'], phone: info['phone'],
                        roles: info['roles'], acls: info['acls'],
                        provider: extra['provider'],
                        access_token: credentials['token']
    end

    def details
      if @details.nil?
        body = cacheable "zu/#{cache_key}/details", 'user' do
          execute_get user_url, {}, request_headers
        end
        @details = Hashie::Mash.new body if body
      end
      @details
    end

    def touch(user_id)
      response = execute_update user_touch_url(user_id), {}, request_headers
      v4_success? response
    end

    def reload
      @details = nil
    end

    def request_headers
      self.class.request_headers access_token
    end

    private

    def cacheable(cache_key, data_key)
      Zuppler.cache.fetch cache_key, expires_in: 60 * 5 do
        response = yield
        raise Zuppler::SkipCache, 'response error, skip cache' unless v4_success? response
        response[data_key]
      end
    rescue Zuppler::SkipCache
      nil
    end

    def cache_key
      id == 'current' ? rand : id
    end

    def user_url
      "#{Zuppler.users_api_url}/users/#{id}.json"
    end
  end
end
