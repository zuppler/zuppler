module Zuppler
  class Choice < Model
    include ActiveAttr::Model
    
    attribute :category
    attribute :item
    attribute :id
    attribute :name
    attribute :multiple, default: true
    attribute :min_qty, default: 0
    attribute :max_qty, default: 0
    attribute :priority
    attribute :order_by_priority

    
    validates_presence_of :name
    validate do
      errors.add :restaurant, 'permalink is required' if restaurant and restaurant.permalink.blank?
    end

    def save
      choice_attributes = filter_attributes attributes, 'category', 'item'
      response = execute_create choices_url, {:choice => choice_attributes}
      if v3_success?(response)
        self.id = response['choice']['id']
      else
        response['errors'].each do |k,v|
          self.errors.add k, v
        end
      end
      v3_success? response
    end

    def restaurant
      category ? category.restaurant : item.restaurant
    end

    protected

    def choices_url
      if category
        "#{Zuppler.api_url('v3')}/restaurants/#{restaurant.permalink}/categories/#{category.id}/choices.json"
      else
        "#{Zuppler.api_url('v3')}/restaurants/#{restaurant.permalink}/items/#{item.id}/choices.json"
      end
    end
  end
end
