module Zuppler
  module Users
    module Providers
      def providers
        if @providers.nil?
          response = execute_get user_providers_url(id), {}, request_headers
          if v4_success? response
            providers = response['providers']
            @providers = providers && providers.any? ? providers.map { |p| Hashie::Mash.new(p) } : []
          end
        end
        @providers
      end

      private

      def user_providers_url(id)
        "#{Zuppler.users_api_url}/users/#{id}/providers.json"
      end
    end
  end
end
