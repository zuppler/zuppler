module Zuppler
  class Item < Model
    include ActiveAttr::Model

    attribute :category
    attribute :id
    attribute :name
    attribute :price, type: Float
    attribute :size

    validates_presence_of :category, :name, :price

    def save
      item_attributes = filter_attributes attributes, 'category'
      response = execute_create items_url, {:item => item_attributes}
      if success? response
        self.id = response['items'].first['id']
      else
        # handle errors
      end
      self
    end

    def restaurant
      category.restaurant
    end

    protected

    def items_url
      "#{Zuppler.api_url}/restaurants/#{category.restaurant.permalink}/categories/#{category.id}/items.json"
    end
  end
end
