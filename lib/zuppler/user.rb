module Zuppler
  class User < Model
    include ActiveAttr::Model

    attribute :name
    attribute :email
    attribute :phone
    attribute :access_token

    def self.find(access_token)
      Zuppler::User.new access_token: access_token
    end

    def details
      if @details.nil?
        response = execute_get user_url, {}, headers
        if v4_success? response
          @details = Hashie::Mash.new response['user']
        else
          if v4_response_code(response) == 401
            fail Zuppler::NotAuthorized, 'not authorized'
          else
            fail 'Zuppler::User#details failed.'
          end
        end
      end
      @details
    end

    def id
      details.id
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
