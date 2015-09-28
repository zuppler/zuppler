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
                        provider: extra['provider'],
                        access_token: credentials['token']
    end

    def details
      if @details.nil?
        response = execute_get user_url, {}, headers
        if v4_success? response
          @details = Hashie::Mash.new response['user']
          self.id = @details.id
        else
          if v4_response_code(response) == 401
            fail Zuppler::NotAuthorized, 'not authorized'
          else
            fail Zuppler::Error, response.message
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

    private

    def headers
      { 'Authorization' => " Bearer #{access_token}" }
    end

    def user_url
      "#{Zuppler.users_api_url}/users/current.json"
    end
  end
end
