module Zuppler
  module Users
    module Search
      def search(token, query)
        response = execute_post search_url, query, request_headers(token)
        Hashie::Mash.new JSON.parse response.body
      end

      def search_url
        "#{Zuppler.users_api_url}/users/search.json"
      end
    end
  end
end
