module Zuppler
  class Channel
    include HTTParty

    def self.find(cid)
      response = get resource_url(cid)
      response
    end

    def self.resource_url(cid)
      Zuppler.api_url + "/channels/#{cid}.json"
    end
  end
end
