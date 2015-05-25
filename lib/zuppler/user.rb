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
          fail 'Zuppler::User#details failed.'
        end
      end
      @details
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
