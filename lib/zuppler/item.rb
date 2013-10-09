module Zuppler
  class Item < Model
    include ActiveAttr::Model

    attribute :category
    attribute :id
    attribute :name
    attribute :price, type: Float

    validates_presence_of :category, :name, :price

    def save
      item_attributes = filter_attributes attributes, 'category'
      response = execute_create items_url, {:item => item_attributes}
      if success? response
        self.id = response['id']
      else
        # handle errors
      end
      self
    end

    protected
    def items_url
      "#{Zuppler.api_url}/restaurants/#{category.restaurant.permalink}/categories/#{category.id}/items.json"
    end
  end
end
