module Zuppler
  class Modifier < Model
    include ActiveAttr::Model

    attribute :choice
    attribute :id
    attribute :name
    attribute :price, type: Float
    attribute :size

    validates_presence_of :choice, :name, :price

    def save
      modifier_attributes = filter_attributes attributes, 'choice'
      response = execute_create modifiers_url, :modifier => modifier_attributes
      if success? response
        self.id = response['modifier']['id']
      else
        #TODO handle errors
      end
      self
    end

    protected

    def success?(response)
      response.success? and response['success'] == true
    end

    def restaurant
      choice.restaurant
    end

    def modifiers_url
      "#{Zuppler.api_url('v3')}/restaurants/#{restaurant.permalink}/choices/#{choice.id}/modifiers.json"
    end
  end
end
