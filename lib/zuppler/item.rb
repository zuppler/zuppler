module Zuppler
  class Item < Model
    include ActiveAttr::Model

    attribute :category
    attribute :id
    attribute :name
    attribute :price, type: Float
    attribute :size
    attribute :priority

    validates_presence_of :category, :name, :price

    def self.find(id, category)
      new :id => id, :category => category
    end

    def save
      if new?
        item_attributes = filter_attributes attributes, 'category'
        response = execute_create items_url, {:item => item_attributes}
        self.id = response['items'].first['id'] if success?(response)
      else
        item_attributes = filter_attributes attributes, 'category', 'id'
        response = execute_update item_url, {:item => item_attributes}
      end
      success? response
    end

    def new?
      id.blank?
    end

    def restaurant
      category.restaurant
    end

    protected

    def item_url
      "#{Zuppler.api_url}/restaurants/#{restaurant.permalink}/items/#{id}.json"
    end

    def items_url
      "#{Zuppler.api_url}/restaurants/#{category.restaurant.permalink}/categories/#{category.id}/items.json"
    end
  end
end
