module Zuppler
  class Menu < Model
    include ActiveAttr::Model

    attribute :restaurant
    attribute :id
    attribute :name
    attribute :priority
    attribute :description
    attribute :active
    attribute :locked, default: true

    validates_presence_of :restaurant, :name
    validate do
      if restaurant && restaurant.permalink.blank?
        errors.add :restaurant, 'permalink is required'
      end
    end

    def self.find(id, restaurant_id)
      new id: id, restaurant_id: restaurant_id
    end

    def save
      menu_attributes = filter_attributes attributes, 'restaurant'
      response = execute_post menus_url, menu: menu_attributes
      if v3_success?(response)
        self.id = response['menu']['id']
      else
        response['errors'].each do |k, v|
          errors.add k, v
        end
      end
      v3_success? response
    end

    def restaurant_id
      @restaurant_id || restaurant.permalink
    end

    protected

    def menus_url
      "#{Zuppler.api_url('v3')}/restaurants/#{restaurant_id}/menus.json"
    end
  end
end
