module Zuppler
  class Category < Model
    include ActiveAttr::Model

    attribute :menu
    attribute :id
    attribute :name
    attribute :description
    attribute :priority
    attribute :priced_by_size

    validates_presence_of :menu, :name
    validate do
      errors.add :menu, 'id is missing' if menu and menu.id.blank?
    end

    def save
      category_attributes = filter_attributes attributes, 'menu'
      response = execute_create categories_url, {:category => category_attributes}
      if v3_success? response
        self.id = response['category']['id']
      else
        response['errors'].each do |k,v|
          self.errors.add k, v
        end
      end
      v3_success? response
    end

    def restaurant
      menu.restaurant
    end

    protected

    def categories_url
      "#{Zuppler.api_url('v3')}/restaurants/#{restaurant.permalink}/menus/#{menu.id}/categories.json"
    end
  end
end
