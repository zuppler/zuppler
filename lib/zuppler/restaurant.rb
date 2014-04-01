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
        unmarshal Zuppler::Restaurant.new, response
      end
    end

    def self.publish(permalink)
      restaurant = find permalink
      restaurant.publish
    end

    def publish
      response = execute_create publish_url, nil
      response.success?
    end

    def save
      restaurant_attributes = filter_attributes attributes, 'id'
      response = execute_create restaurants_url, {:restaurant => restaurant_attributes}
      if v3_success?(response)
        self.class.unmarshal self, response
      else
        nil
      end
    end

    private

    def self.unmarshal(restaurant, response)
      restaurant.id = response['restaurant']['id']
      restaurant.permalink = response['restaurant']['permalink']
      restaurant
    end

    def restaurants_url
      "#{Zuppler.api_url('v3')}/restaurants.json"
    end
    def self.restaurant_url(permalink)
      "#{Zuppler.api_url('v3')}/restaurants/#{permalink}.json"
    end

    def publish_url
      "#{Zuppler.api_url('v3')}/restaurants/#{permalink}/publish.json"
    end
  end
end
