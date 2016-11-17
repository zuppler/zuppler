module Zuppler
  module Users
    module Providers
      def providers(&ablock)
        request = request user_providers_url, {}
        response = request.execute_read self, &ablock
        if v4_success? response
          response['providers'].map { |p| Hashie::Mash.new p }
        else
          []
        end
      end

      def _provider(type, &ablock)
        request = request user_provider_url(type), {}
        response = request.execute_read self, &ablock
        Hashie::Mash.new response['provider'] if v4_success? response
      end

      private

      def user_providers_url
        "#{Zuppler.users_api_url}/users/#{id}/providers.json"
      end

      def user_provider_url(type)
        "#{Zuppler.users_api_url}/users/#{id}/providers/#{type}.json"
      end
    end
  end
end
