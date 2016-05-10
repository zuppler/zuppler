module Zuppler
  class User < Model
    include ActiveAttr::Model

    attribute :id
    attribute :name
    attribute :email
    attribute :phone
    attribute :roles
    attribute :access_token
    attribute :provider

    def self.find(access_token)
      Zuppler::User.new access_token: access_token
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
        Retriable.retriable on: Zuppler::RetryError, base_interval: 1 do
          response = execute_get user_url, {}, headers
          if v4_success? response
            @details = Hashie::Mash.new response['user']
            self.id = @details.id
          else
            if v4_response_code(response) == 401
              fail Zuppler::NotAuthorized, 'not authorized'
            elsif v4_response_code(response) > 500
              fail Zuppler::RetryError, response.message
            else
              fail Zuppler::ServerError, response.message
            end
          end
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

    private

    def headers
      { 'Authorization' => " Bearer #{access_token}" }
    end

    def user_url
      "#{Zuppler.users_api_url}/users/current.json"
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
  end
end
