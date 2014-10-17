module Zuppler
  class Channel
    include HTTParty

    class << self
      def find(id)
        response = get resource_url(id)
        response
      end

      def resource_url(_cid)
        Zuppler.api_url + '.json'
      end
    end

    def restaurants
      []
    end
  end
end
