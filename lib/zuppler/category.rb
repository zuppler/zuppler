module Zuppler
  class Category < Model
    include ActiveAttr::Model

    attribute :menu
    attribute :id
    attribute :name

    validates_presence_of :menu, :name
    validate do
      errors.add :menu, 'id is missing' if menu and menu.id.blank?
    end

    def save
      category_attributes = filter_attributes attributes, 'menu'
      response = execute_create categories_url, {:category => category_attributes}
      if success? response
        self.id = response['id']
      else
        # handle errors
      end
      self
    end

    def restaurant
      menu.restaurant
    end

    protected
    def categories_url
      "#{Zuppler.api_url}/restaurants/#{restaurant.permalink}/menus/#{menu.id}/categories.json"
    end
  end
end
