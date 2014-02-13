module Zuppler
  class Choice < Model
    include ActiveAttr::Model
    
    attribute :category
    attribute :item
    attribute :id
    attribute :name
    attribute :active
    attribute :multiple
    attribute :min_qty, default: 0
    attribute :max_qty
    attribute :priority
    attribute :order_by_priority

    
    validates_presence_of :name
    validate do
      errors.add :restaurant, 'permalink is required' if restaurant and restaurant.permalink.blank?
    end

    def save
      if new?
        choice_attributes = filter_attributes attributes, 'category', 'item'
        response = execute_create choices_url, {:choice => choice_attributes}
        self.id = response['choice']['id'] if v3_success?(response)
      else
        choice_attributes = filter_attributes attributes, 'category', 'item', 'id'
        response = execute_update choice_url, {:choice => choice_attributes}
      end
      v3_success? response
    end

    def destroy
      self.active = false
      self.min_qty = nil
      save
    end

    def restaurant
      category ? category.restaurant : item.restaurant
    end

    protected

    def choice_url
        "#{Zuppler.api_url('v3')}/restaurants/#{restaurant.permalink}/choices/#{id}.json"
    end

    def choices_url
      if category
        "#{Zuppler.api_url('v3')}/restaurants/#{restaurant.permalink}/categories/#{category.id}/choices.json"
      else
        "#{Zuppler.api_url('v3')}/restaurants/#{restaurant.permalink}/items/#{item.id}/choices.json"
      end
    end
  end
end
