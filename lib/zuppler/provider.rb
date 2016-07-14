module Zuppler
  class Provider < Model
    include ActiveAttr::Model

    attr_accessor :provider_id
    attr_accessor :user_id
    attr_accessor :token

    def self.find(token, user_id, id)
      zu = Zuppler::Provider.new token: token, user_id: user_id, provider_id: id
      Rails.logger.debug "#{zu.provider_id}, #{zu.token}"
      zu
    end

    def details
      if @details.nil?
        response = execute_get provider_url, {}, headers
        @details = Hashie::Mash.new(response['provider']) if v4_success?(response)
      end
      @details
    end

    def provider
      @details.provider
    end

    def id
      @details.id
    end

    private

    def provider_url
      "#{Zuppler.users_api_url}/users/#{user_id}/providers/#{provider_id}.json"
    end

    def headers
      { 'Authorization' => " Bearer #{token}" }
    end
  end
end
