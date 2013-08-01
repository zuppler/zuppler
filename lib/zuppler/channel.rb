module Zuppler
  class Channel
    include HTTParty

    class << self
      def find(cid)
        response = get resource_url(cid)
        response
      end

      def resource_url(cid)
        Zuppler.api_url + ".json"
      end
    end

    def restaurants
      []
    end
  end
end
