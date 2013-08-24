module Zuppler
  class Restaurant < Model
    include HTTParty

    self.attribute_keys = [:id, :name, :remote_id, :logo, :location, :owner]

    validates_presence_of :name, :remote_id, :logo, :location, :owner

    class << self
      def restaurants_url
        "#{Zuppler.api_url}/restaurants.json"
      end

      def create(options = {})
        Zuppler.check
        restaurant = Restaurant.new
        yield restaurant
        
        options = {:body => {:restaurant => restaurant.attributes}}
        response = post restaurants_url, options
        log response, options
        if success?(response)
          restaurant.id = response.body['id']
          restaurant
        else
          nil
        end
      end

      def all
        Zuppler.check
        get restaurants_url
      end
      
      def success?(response)
        response.success? and response['valid']
      end
    end
  end
end
