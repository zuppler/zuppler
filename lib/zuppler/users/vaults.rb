module Zuppler
  module Users
    module Vaults
      def vaults(&ablock)
        request = request user_vaults_url, {}
        response = request.execute_read self, &ablock
        if v4_success? response
          response['vaults'].map { |p| Hashie::Mash.new p }
        else
          []
        end
      end

      def create_vault(options)
        requires! options, :name, :brand, :number, :expiration_date, :uid
        vault_attributes = { vault: options }
        response = execute_post user_vaults_url, vault_attributes, request_headers
        success = v4_success? response
        yield success, vault_attributes, response if block_given?
        success
      end

      def update_vault(options)
        requires! options, :uid, :profile_id
        vault_attributes = { vault: options }
        response = execute_update vault_update_url, vault_attributes, request_headers
        success = v4_success? response
        yield success, vault_attributes, response if block_given?
        success
      end

      private

      def user_vaults_url
        url = "#{Zuppler.users_api_url}/users/#{id}/vaults.json"
        url += "?gateway_id=#{gateway_id}" if gateway_id
        url += "&merchant_id=#{merchant_id}" if merchant_id
        url
      end

      def vault_update_url
        "#{Zuppler.users_api_url}/users/#{id}/vaults/update_profile_id.json"
      end
    end
  end
end
