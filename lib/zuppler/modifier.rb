module Zuppler
  class Modifier < Model
    include ActiveAttr::Model

    attribute :choice
    attribute :id
    attribute :parent_id
    attribute :name
    attribute :price, type: Float
    attribute :size
    attribute :priority
    attribute :active

    validates_presence_of :choice, :name, :price

    def self.find(id, choice)
      new id: id, choice: choice
    end

    def save
      if new?
        modifier_attributes = filter_attributes attributes, 'choice', 'parent_id'
        response = execute_create modifiers_url, :modifier => modifier_attributes
        if v3_success? response
          self.id = response['modifier']['id']
          self.parent_id = response['modifier']['parent_id']
        end
      else
        modifier_attributes = filter_attributes attributes, 'choice', 'id'
        response = execute_update modifier_url, {:modifier => modifier_attributes}
      end
      v3_success? response
    end

    protected

    def new?
      id.blank?
    end

    def restaurant
      choice.restaurant
    end

    def modifier_url
      "#{Zuppler.api_url('v3')}/restaurants/#{restaurant.permalink}/modifiers/#{id}.json"
    end

    def modifiers_url
      "#{Zuppler.api_url('v3')}/restaurants/#{restaurant.permalink}/choices/#{choice.id}/modifiers.json"
    end
  end
end
