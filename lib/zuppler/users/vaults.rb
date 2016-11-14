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

      def create_vault(options)
        requires! options, :name, :brand, :number, :expiration_date, :uid
        vault_attributes = { vault: options }
        response = execute_post user_vaults_url(id), vault_attributes, request_headers
        success = v4_success? response
        yield success, vault_attributes, response if block_given?
        success
      end

      private

      def user_vaults_url(id)
        "#{Zuppler.users_api_url}/users/#{id}/vaults.json"
      end
    end
  end
end
