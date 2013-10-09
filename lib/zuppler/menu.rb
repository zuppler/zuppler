module Zuppler
  class Menu < Model
    include ActiveAttr::Model
    
    attribute :restaurant
    attribute :id
    attribute :name
    attribute :special, default: true
    
    validates_presence_of :restaurant, :name
    validate do
      errors.add :restaurant, 'permalink is required' if restaurant and restaurant.permalink.blank?
    end

    def save
      menu_attributes = filter_attributes attributes, 'restaurant'
      response = execute_create menus_url, {:menu => menu_attributes}
      if success?(response)
        self.id = response['id']
      else
        response['errors'].each do |k,v|
          self.errors.add k, v
        end
      end
      self
    end

    protected
    
    def menus_url
      "#{Zuppler.api_url}/restaurants/#{restaurant.permalink}/menus.json"
    end
  end
end
