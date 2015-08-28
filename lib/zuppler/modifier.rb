module Zuppler
  class Modifier < Model
    include ActiveAttr::Model

    attribute :restaurant

    attribute :id
    attribute :name
    attribute :description
    attribute :multiple
    attribute :min_qty, default: 0
    attribute :max_qty
    attribute :priority
    attribute :active

    validates_presence_of :restaurant, :name

    def self.find(id, restaurant_id)
      new id: id, restaurant_id: restaurant_id
    end

    def save
      if new?
        modifier_attributes = filter_attributes attributes, 'restaurant'
        response = execute_post modifiers_url, modifier: modifier_attributes
        self.id = resource_id(response) if v4_success?(response)
      else
        modifier_attributes = filter_attributes attributes, 'restaurant', 'id'
        response = execute_update modifier_url, modifier: modifier_attributes
      end
      handle response, 'v4'
    end

    def destroy
      self.active = false
      self.min_qty = nil
      save
    end

    def restaurant_id
      @restaurant_id || restaurant.permalink
    end

    protected

    def resource_id(response)
      $1 if response.headers['Location'] =~ /\/modifiers\/(\d+).json/
    end

    def modifier_url
      "#{Zuppler.restaurants_api_url('v4')}/restaurants/#{restaurant_id}/modifiers/#{id}.json"
    end

    def modifiers_url
      "#{Zuppler.restaurants_api_url('v4')}/restaurants/#{restaurant_id}/modifiers.json"
    end
  end
end
