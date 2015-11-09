module Zuppler
  class Ingredient < Model
    include ActiveAttr::Model

    attribute :choice
    attribute :option_id
    attribute :id
    attribute :parent_id
    attribute :name
    attribute :description
    attribute :price, type: Float
    attribute :size
    attribute :priority
    attribute :active
    attribute :default

    validates_presence_of :choice, :name, :price

    def self.find(id, restaurant_id)
      new id: id, restaurant_id: restaurant_id
    end

    def save
      if new?
        modifier_attributes = filter_attributes attributes, 'choice', 'parent_id'
        response = execute_post modifiers_url, modifier: modifier_attributes
        if v3_success? response
          self.id = response['modifier']['id']
          self.parent_id = response['modifier']['parent_id']
        end
      else
        modifier_attributes = filter_attributes attributes, 'choice', 'id'
        modifier_attributes[:customization_id] = choice.id if choice
        response = execute_update modifier_url, modifier: modifier_attributes
      end
      handle response
    end

    def destroy
      self.active = false
      save
    end

    protected

    def restaurant_id
      @restaurant_id || choice.restaurant_id
    end

    def modifier_url
      "#{Zuppler.api_url('v3')}/restaurants/#{restaurant_id}/modifiers/#{id}.json"
    end

    def modifiers_url
      "#{Zuppler.api_url('v3')}/restaurants/#{restaurant_id}/choices/#{choice.id}/modifiers.json"
    end
  end
end
