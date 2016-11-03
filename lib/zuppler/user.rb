require 'zuppler/user_utils/search'

module Zuppler
  class User < Model
    include ActiveAttr::Model
    include Zuppler::UserUtils::Search

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
      Zuppler::User.new id: info['id'],
                        name: info['name'],
                        email: info['email'],
                        phone: info['phone'],
                        roles: info['roles'],
                        acls: info['acls'],
                        provider: extra['provider'],
                        access_token: credentials['token']
    end

    def details
      if @details.nil?
        response = execute_get user_url, {}, headers
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

    def providers
      if @providers.nil?
        response = execute_get user_providers_url(id), {}, headers
        if v4_success? response
          providers = response['providers']
          @providers = providers && providers.any? ? providers.map { |p| Hashie::Mash.new(p) } : []
        end
      end
      @providers
    end

    def vaults
      if @vaults.nil?
        response = execute_get user_vaults_url(id), {}, headers
        if v4_success? response
          vaults = response['vaults']
          @vaults = vaults && vaults.any? ? vaults.map { |p| Hashie::Mash.new(p) } : []
        end
      end
      @vaults
    end

    def acls(param = nil)
      param ? details.acls[param] : details.acls
    end

    def grant(user_id, options = {})
      response = execute_update user_grant_url(user_id), { acls: options }, headers
      v4_success? response
    end

    def revoke(user_id, options = {})
      response = execute_update user_revoke_url(user_id), { acls: options }, headers
      v4_success? response
    end

    def touch(user_id)
      response = execute_update user_touch_url(user_id), {}, headers
      v4_success? response
    end

    def print_params
      details
      if @print_params.nil?
        response = execute_get user_print_params_url(id), {}, headers
        if v4_success? response
          print_params = response['print_params']
          @print_params = print_params
        end
      end
      @print_params
    end

    def update_print_params(print_params)
      details
      response = execute_update user_print_params_url(id), { print_params: print_params }, headers
      Rails.logger.debug 'response.body:'
      Rails.logger.debug response.body
      v4_success? response
    end

    private

    def headers
      { 'Authorization' => " Bearer #{access_token}" }
    end

    def user_url
      user_id = id || 'current'
      "#{Zuppler.users_api_url}/users/#{user_id}.json"
    end

    def user_grant_url(id)
      "#{Zuppler.users_api_url}/users/#{id}/grant.json"
    end

    def user_revoke_url(id)
      "#{Zuppler.users_api_url}/users/#{id}/revoke.json"
    end

    def user_touch_url(id)
      "#{Zuppler.users_api_url}/users/#{id}/touch.json"
    end

    def user_providers_url(id)
      "#{Zuppler.users_api_url}/users/#{id}/providers.json"
    end

    def user_vaults_url(id)
      "#{Zuppler.users_api_url}/users/#{id}/vaults.json"
    end

    def user_print_params_url(id)
      "#{Zuppler.users_api_url}/users/#{id}/print_params.json"
    end
  end
end
