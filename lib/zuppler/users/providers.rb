module Zuppler
  module Users
    module Providers
      def providers
        if @providers.nil?
          response = execute_get user_providers_url, {}, request_headers
          if v4_success? response
            providers = response['providers']
            @providers = providers && providers.any? ? providers.map { |p| Hashie::Mash.new(p) } : []
          end
        end
        @providers
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
        "#{Zuppler.users_api_url}/users/#{id}/providers/#{type}"
      end
    end
  end
end
