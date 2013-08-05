module Zuppler
  class Restaurant
    include HTTParty
    attr_accessor :name, :rid, :logo, :location, :owner

    class << self
      def all
        Zuppler.check

        response = get restaurants_url
        response
      end

      def create
        Zuppler.check

        restaurant = Restaurant.new
        yield restaurant
        restaurant.save
      end

      def find(params)
        {'id' => 1}
      end

      def restaurants_url
        Zuppler.api_url + "/restaurants.json"
      end
    end

    def save
      response = self.class.post self.class.restaurants_url, :body => {:restaurant => 
        {:name => name, :remote_id => rid, :logo => logo, :location => location, :owner => owner}}
#      puts response
      response.success?
    end

  end
end
