module Zuppler
  module Users
    module ProviderKeys
      # {:id=>2351, :permalink=>"fdsfasfaaaa", :data=>{"levelup"=>{"app_key"=>"fdsafdsafsa", "secret_key"=>"fdsafasfasfas"}}}
      def save_providers_keys(token, params)
        headers = request_headers(token)
        body = create_body(params)

        execute_post base_url, body.to_json, headers
      end

      def load_providers_keys(token, channel_id)
        headers = request_headers(token)
        body = {channel_id: channel_id}.to_json

        response = execute_get base_url, body, headers

        JSON.parse response.body
      end
      
# {:id=>2351, :permalink=>"fdsfasfaaaa", :data=>{"levelup"=>{"app_key"=>"fdsafdsafsa", "secret_key"=>"fdsafasfasfas"}}}
      def update_providers_keys(token, params)
        headers = request_headers(token)
        body = create_body(params)

        execute_update base_url, body.to_json, headers
      end

      private

      def create_body(params)
        {
          channel_data: {id: params[:id], permalink: params[:permalink]},
          providers_data: params[:data]
        }
      end

      def base_url
        "#{Zuppler.users_api_url}/provider_keys"
      end
    end
  end
end
