module Zuppler
  module Users
    module Vaults
      def vaults
        if @vaults.nil?
          response = execute_get user_vaults_url(id), {}, request_headers
          if v4_success? response
            vaults = response['vaults']
            @vaults = vaults && vaults.any? ? vaults.map { |p| Hashie::Mash.new(p) } : []
          end
        end
        @vaults
      end

      private

      def user_vaults_url(id)
        "#{Zuppler.users_api_url}/users/#{id}/vaults.json"
      end
    end
  end
end
