module Zuppler
  class Restaurant < Model
    include ActiveAttr::Model, HTTParty

    attribute :id
    attribute :permalink
    attribute :name
    attribute :address
    attribute :configurations

    class << self
      def create(options = {})
        restaurant = new options
        yield restaurant if block_given?
        restaurant.save
        restaurant
      end
    end
    include Zuppler::Macros

    validates_presence_of :name

    def self.find(permalink)
      Zuppler::Restaurant.new permalink: permalink
    end

    def publish(options = {})
      response = execute_update publish_url, options
      response.success?
    end

    def pause(options = {})
      response = execute_update pause_url, options
      response.success?
    end

    def resume(options = {})
      response = execute_update resume_url, options
      response.success?
    end

    def set_configurations(options = {})
      configuration_attributes = filter_attributes attributes, 'id', 'permalink'
      response = execute_update configurations_url, configurations: configuration_attributes
      response.success?
    end

    def save
      if new?
        restaurant_attributes = filter_attributes attributes, 'id'
        response = execute_post restaurants_url, restaurant: restaurant_attributes
      else
        restaurant_attributes = filter_attributes attributes, 'id', 'permalink'
        response = execute_update restaurant_url, restaurant: restaurant_attributes
      end
      self.class.unmarshal self, response if v3_success?(response)
      handle response
    end

    def exists?
      !details.nil?
    end

    def details
      if @details.nil?
        response = execute_get restaurant_url, {}, {}
        if v3_success? response
          @details = Hashie::Mash.new response['restaurant']
        end
      end
      @details
    end

    private

    def new?
      permalink.blank?
    end

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

    def restaurant_url
      self.class.restaurant_url permalink
    end

    def publish_url
      "#{Zuppler.api_url('v3')}/restaurants/#{permalink}/publish.json"
    end

    def pause_url
      "#{Zuppler.api_url('v3')}/restaurants/#{permalink}/pause.json"
    end

    def resume_url
      "#{Zuppler.api_url('v3')}/restaurants/#{permalink}/pause.json"
    end

    def configurations_url
      "#{Zuppler.api_url('v3')}/restaurants/#{permalink}/configurations.json"
    end
  end
end
