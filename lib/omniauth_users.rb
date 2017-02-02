module OmniAuth
  module Strategies
    class Users < OmniAuth::Strategies::OAuth2
      option :name, :users
      option :client_options, site: ::Zuppler.users_url

      uid { data['uid'] }

      info do
        {
          id: data['info']['id'],
          name: data['info']['name'],
          email: data['info']['email'],
          phone: data['info']['phone'],
          roles: data['info']['roles']
        }
      end

      extra do
        {
          provider: data['provider']
        }
      end

      def request_phase
        options[:authorize_params][:provider] = request.params['provider']
        options[:authorize_params][:provider_page] = request.params['provider_page']
        super
      end

      def data
        @data ||= access_token.get('/users/current.json').parsed
      end
    end
  end
end
