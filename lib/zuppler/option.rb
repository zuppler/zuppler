module Zuppler
  class Option < Model
    include ActiveAttr::Model

    attribute :modifier

    attribute :id
    attribute :name
    attribute :description
    attribute :price, type: Integer
    attribute :priority
    attribute :active

    validates_presence_of :modifier, :name, :price

    def self.find(id, restaurant_id)
      new id: id, restaurant_id: restaurant_id
    end

    def save
      if new?
        option_attributes = filter_attributes attributes, 'modifier'
        response = execute_post options_url, option: option_attributes
        self.id = resource_id response if v4_success? response
      else
        option_attributes = filter_attributes attributes, 'modifier', 'id'
        response = execute_update option_url, option: option_attributes
      end
      handle response, 'v4'
    end

    def destroy
      self.active = false
      save
    end

    protected

    def resource_id(response)
      $1 if response.headers['Location'] =~ /\/options\/(\d+).json/
    end

    def restaurant_id
      @restaurant_id || modifier.restaurant_id
    end

    def option_url
      "#{Zuppler.restaurants_api_url('v4')}/restaurants/#{restaurant_id}/options/#{id}.json"
    end

    def options_url
      "#{Zuppler.restaurants_api_url('v4')}/restaurants/#{restaurant_id}/modifiers/#{modifier.id}/options.json"
    end
  end
end
