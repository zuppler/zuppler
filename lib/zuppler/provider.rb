module Zuppler
  class Provider < Model
    include ActiveAttr::Model

    attribute :id
    attribute :user_id

    def self.find(user_id, id)
      Zuppler::Provider.new user_id: user_id, id: id
    end

    def details
      if @details.nil?
        response = execute_get provider_url, {}, {}
        @details = Hashie::Mash.new(response['provider']) if v4_success?(response)
      end
      @details
    end

    def provider
      details.provider
    end

    def token
      details.token
    end

    private

    def provider_url
      "#{Zuppler.users_api_url}/users/#{user_id}/providers/#{id}.json"
    end
  end
end
