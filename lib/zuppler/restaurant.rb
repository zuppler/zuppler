module Zuppler
  class OwnerValidator < ActiveModel::Validator
    def validate(record)
      if record.owner
        record.errors[:owner] = "name is required" if record.owner[:name].blank?
        record.errors[:owner] = "email is required" if record.owner[:email].blank?
        record.errors[:owner] = "phone is required" if record.owner[:phone].blank?
      end
    end
  end

  class Restaurant < Model
    include HTTParty

    class << self
      def create(options = {})
        restaurant = new options
        yield restaurant if block_given?
        restaurant.save
      end
    end
    include Zuppler::Macros
    
    self.attribute_keys = [:id, :name, :remote_id, :logo, :location, :owner]

    validates_presence_of :name, :remote_id, :logo, :location, :owner
    validates_with OwnerValidator

    def save
      options = {:body => {:restaurant => self.attributes}}
      response = self.class.post restaurants_url, options
      log response, options
      if success?(response)
        self.id = response.body['id']
        self
      else
        nil
      end
    end
    
    private

    def restaurants_url
      "#{Zuppler.api_url}/restaurants.json"
    end
    
    def success?(response)
      response.success? and response['valid']
    end
  end
end
