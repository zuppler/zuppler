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
    attribute :remote_id

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
      if new?
        menu_attributes = filter_attributes attributes, 'restaurant'
        response = execute_post menus_url, menu: menu_attributes
        self.id = response['menu']['id'] if v3_success? response
      else
        menu_attributes = filter_attributes attributes, 'restaurant', 'id'
        response = execute_update menu_url, menu: menu_attributes
      end
      success = handle response
      yield success, response if block_given?
      success
    end

    def destroy
      self.active = false
      save
    end

    def restaurant_id
      @restaurant_id || restaurant.permalink
    end

    protected

    def menus_url
      "#{Zuppler.api_url('v3')}/restaurants/#{restaurant_id}/menus.json"
    end

    def menu_url
      "#{Zuppler.api_url('v3')}/restaurants/#{restaurant_id}/menus/#{id}.json"
    end
  end
end
