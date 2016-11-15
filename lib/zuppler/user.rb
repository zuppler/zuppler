require 'zuppler/users/search'
require 'zuppler/users/acls'
require 'zuppler/users/vaults'
require 'zuppler/users/providers'
require 'zuppler/users/zupps'

module Zuppler
  class User < Model
    include ActiveAttr::Model
    include Zuppler::Users::Acls, Zuppler::Users::Vaults
    include Zuppler::Users::Providers, Zuppler::Users::Zupps
    extend Zuppler::Users::Search

    attribute :id
    attribute :name
    attribute :email
    attribute :phone
    attribute :roles
    attribute :access_token
    attribute :provider

    def self.find(access_token, id = nil)
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

    def role?(role)
      details.roles.include? role
    end

    def user?
      details.roles.empty?
    end

    def channel?
      role? 'channel'
    end

    def restaurant?
      role? 'restaurant'
    end

    def restaurant_staff?
      role? 'restaurant_staff'
    end

    def ambassador?
      role? 'ambassador'
    end

    def config?
      role? 'config'
    end

    def support?
      role? 'support'
    end

    def admin?
      role? 'admin'
    end

    def touch(user_id)
      response = execute_update user_touch_url(user_id), {}, request_headers
      v4_success? response
    end

    def print_params
      details
      if @print_params.nil?
        response = execute_get user_print_params_url(id), {}, request_headers
        if v4_success? response
          print_params = response['print_params']
          @print_params = print_params
        end
      end
      @print_params
    end

    def update_print_params(print_params)
      details
      response = execute_update user_print_params_url(id), { print_params: print_params }, request_headers
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
      user_id = id || 'current'
      "#{Zuppler.users_api_url}/users/#{user_id}.json"
    end

    def user_print_params_url(id)
      "#{Zuppler.users_api_url}/users/#{id}/print_params.json"
    end
  end
end
