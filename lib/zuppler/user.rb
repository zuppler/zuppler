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
        response = execute_get user_url, {}, request_headers
        if v4_success? response
          @details = Hashie::Mash.new response['user']
          self.id = @details.id
        end
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

    private

    def request_headers
      self.class.request_headers access_token
    end

    def user_url
      "#{Zuppler.users_api_url}/users/#{id}.json"
    end

    def user_print_params_url(id)
      "#{Zuppler.users_api_url}/users/#{id}/print_params.json"
    end
  end
end
