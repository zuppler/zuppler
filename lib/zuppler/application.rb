module Zuppler
  class Application
    attr_reader :client_id, :client_secret

    def initialize(client_id = ENV['CLIENT_ID'], client_secret = ENV['CLIENT_SECRET'])
      @client_id = client_id
      @client_secret = client_secret
      raise 'client_id is required' if @client_id.blank?
      raise 'client_secret is required' if @client_secret.blank?
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
