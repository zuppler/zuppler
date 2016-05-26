module Zuppler
  class Application
    attr_reader :client_id, :client_secret

    def initialize(client_id = ENV['CLIENT_ID'], client_secret = ENV['CLIENT_SECRET'])
      raise ArgumentError, 'client_id/client_secret params are required' if client_id.blank? || client_secret.blank?
      @client_id = client_id
      @client_secret = client_secret
    end

    def access_token(scope)
      raise 'Application scope is required' if scope.blank?

      Zuppler.cache.fetch "za/#{scope}/access_token", expires_in: 12 * 60 * 60 do
        body = {
          client_id: client_id, client_secret: client_secret,
          grant_type: 'client_credentials', scope: scope.to_s
        }
        response = HTTParty.post "#{Zuppler.users_url}/oauth/token", body: body
        raise "Access token for '#{scope}' scope failed: #{response.message}" unless response.success?
        response['access_token']
      end
    end
  end
end
