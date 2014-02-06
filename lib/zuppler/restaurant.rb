module Zuppler
  class Restaurant < Model
    include ActiveAttr::Model, HTTParty

    attribute :id
    attribute :permalink
    attribute :name
    attribute :address

    class << self
      def create(options = {})
        restaurant = new options
        yield restaurant if block_given?
        restaurant.save
      end
    end
    include Zuppler::Macros
    
    validates_presence_of :name

    def self.find(permalink)
      response = execute_find restaurant_url(permalink)
      if v3_success?(response)
        @restaurant = Zuppler::Restaurant.new
        @restaurant.id = response['restaurant']['id']
        @restaurant.permalink = response['restaurant']['permalink']
        @restaurant
      end
    end

    def save
      restaurant_attributes = filter_attributes attributes, 'id'
      response = execute_create restaurants_url, {:restaurant => restaurant_attributes}
      if v3_success?(response)
        self.id = response['restaurant']['id']
        self.permalink = response['restaurant']['permalink']
      else
        response['errors'].each do |k,v|
          self.errors.add k, v
        end
      end
      self
    end
    
    private

    def restaurants_url
      "#{Zuppler.api_url('v3')}/restaurants.json"
    end
    def self.restaurant_url(permalink)
      "#{Zuppler.api_url('v3')}/restaurants/#{permalink}.json"
    end

  end
end
