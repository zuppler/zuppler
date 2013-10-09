module Zuppler
  class Restaurant < Model
    include ActiveAttr::Model, HTTParty

    attribute :id
    attribute :permalink
    attribute :name
    attribute :remote_id
    attribute :logo
    attribute :location
    attribute :owner
    attribute :configuration

    class << self
      def create(options = {})
        restaurant = new options
        yield restaurant if block_given?
        restaurant.save
      end
    end
    include Zuppler::Macros
    
    validates_presence_of :name, :remote_id, :logo, :location, :owner
    validate do
      if owner
        errors[:owner] = "name is required" if owner[:name].blank?
        errors[:owner] = "email is required" if owner[:email].blank?
        errors[:owner] = "phone is required" if owner[:phone].blank?
      end
    end

    def save
      restaurant_attributes = filter_attributes attributes, 'id'
      response = execute_create restaurants_url, {:restaurant => restaurant_attributes}
      if success?(response)
        self.id = response['id']
        self.permalink = response['permalink']
      else
        response['errors'].each do |k,v|
          self.errors.add k, v
        end
      end
      self
    end
    
    private

    def restaurants_url
      "#{Zuppler.api_url}/restaurants.json"
    end
    
    def success?(response)
      response.success? and response['valid'] == true
    end
  end
end
