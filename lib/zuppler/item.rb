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
    attribute :image_url
    attribute :min_qty

    validates_presence_of :category, :name, :price

    def self.find(id, restaurant_id)
      new id: id, restaurant_id: restaurant_id
    end

    def save
      if new?
        item_attributes = filter_attributes attributes, 'category'
        response = execute_post items_url, item: item_attributes
        self.id = response['item']['id'] if v3_success?(response)
      else
        item_attributes = filter_attributes attributes, 'category', 'id'
        response = execute_update item_url, item: item_attributes
      end
      handle response
    end

    def destroy
      self.active = false
      save
    end

    def restaurant_id
      @restaurant_id || category.restaurant_id
    end

    protected

    def item_url
      "#{Zuppler.api_url('v3')}/restaurants/#{restaurant_id}/items/#{id}.json"
    end

    def items_url
      "#{Zuppler.api_url('v3')}/restaurants/#{restaurant_id}/categories/#{category.id}/items.json"
    end
  end
end
