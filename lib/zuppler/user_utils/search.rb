module Zuppler
  module UserUtils
    module Search
      def search(query)
        details
        search_url = "#{::Zuppler.users_api_url}/users/search.json"
        execute_post search_url, { query: query }, headers
      end
    end
  end
end
