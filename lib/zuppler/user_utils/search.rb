module Zuppler
  module UserUtils
    module Search
      module ClassMethods
        def search(token, query)
          u = find(token)
          u.search(query)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      def search(query)
        search_url = "#{::Zuppler.users_api_url}/users/search.json"
        details
        response = execute_post search_url, { query: query }, headers
        if v4_success? response
          body = JSON.parse(response.body)

          pagination = body['pagination']
          users = body['users']
          users_mash = users && users.any? ? users.map { |p| Hashie::Mash.new(p) } : []
          Hashie::Mash.new pagination: pagination, users: users_mash
        else
          Hashie::Mash.new pagination: {}, users: []
        end
      end
    end
  end
end
