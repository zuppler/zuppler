module Zuppler
  class Search < Model
    include ActiveAttr::Model, HTTParty

    def self.search query
      execute_post search_url, {query: query}
    end

    private
    def search_url
      "#{Zuppler.api_url('v3')}/search.json"
    end
  end
end
