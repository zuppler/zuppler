module Zuppler
  class Menu < Model
    include ActiveAttr::Model
    
    attribute :restaurant
    attribute :id
    attribute :name
    attribute :priority
    
    validates_presence_of :restaurant, :name
    validate do
      errors.add :restaurant, 'permalink is required' if restaurant and restaurant.permalink.blank?
    end

    def save
      menu_attributes = filter_attributes attributes, 'restaurant'
      response = execute_create menus_url, {:menu => menu_attributes}
      if v3_success?(response)
        self.id = response['menu']['id']
      else
        response['errors'].each do |k,v|
          self.errors.add k, v
        end
      end
      v3_success? response
    end

    protected
    
    def menus_url
      "#{Zuppler.api_url('v3')}/restaurants/#{restaurant.permalink}/menus.json"
    end
  end
end
