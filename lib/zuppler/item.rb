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
    attribute :alias_name
    attribute :featured
    attribute :force
    attribute :dish_id
    attribute :remote_id

    validates_presence_of :category, :name, :price

    def self.find(id, restaurant_id)
      new id: id, restaurant_id: restaurant_id
    end

    def save
      if new?
        item_attributes = filter_attributes attributes, 'category'
        response = execute_post items_url, item: item_attributes
        if v3_success?(response)
          self.id = response['item']['id']
          self.dish_id = response['item']['dish_id'] if response['item']['dish_id'].present?
        end
      else
        item_attributes = filter_attributes attributes, 'category', 'id'
        item_attributes[:category_id] = category.id if category
        response = execute_update item_url, item: item_attributes
        self.dish_id = response['item']['dish_id'] if response['item'].present? && response['item']['dish_id'].present?
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
