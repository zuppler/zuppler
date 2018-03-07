module Zuppler
  class SearchOrders < Model
    include ActiveAttr::Model, HTTParty

    def self.search query
      execute_post search_url, query
    end

    private
    def search_url
      "#{Zuppler.orders_api_url}/orders.json"
    end
  end
end
