module Zuppler
  class Item < Model
    include ActiveAttr::Model

    attribute :category
    attribute :id
    attribute :name
    attribute :description
    attribute :price, type: Float
    attribute :active
    attribute :priority
    attribute :size_name
    attribute :size_priority

    validates_presence_of :category, :name, :price

    def self.find(id, category)
      new :id => id, :category => category
    end

    def save
      if new?
        item_attributes = filter_attributes attributes, 'category'
        response = execute_create items_url, {:item => item_attributes}
        self.id = response['item']['id'] if v3_success?(response)
        v3_success? response
      else
        item_attributes = filter_attributes attributes, 'category', 'id'
        response = execute_update item_url, {:item => item_attributes}
        v3_success? response
      end
    end

    def destroy
      self.active = false
      save
    end

    def restaurant
      category.restaurant
    end

    protected

    def item_url
      "#{Zuppler.api_url('v3')}/restaurants/#{restaurant.permalink}/items/#{id}.json"
    end

    def items_url
      "#{Zuppler.api_url('v3')}/restaurants/#{category.restaurant.permalink}/categories/#{category.id}/items.json"
    end
  end
end
