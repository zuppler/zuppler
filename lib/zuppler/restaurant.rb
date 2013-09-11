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
  class ConfigurationValidator < ActiveModel::Validator
    def validate(record)
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
    
    self.attribute_keys = [:id, :permalink, :name, :remote_id, :logo, :location, :owner, :configuration]

    validates_presence_of :name, :remote_id, :logo, :location, :owner
    validates_with OwnerValidator, ConfigurationValidator

    def save
      restaurant_attributes = self.attributes.reject{|k,v| k == :id or v.nil?}
      options = {:body => {:restaurant => restaurant_attributes}}
      response = self.class.post restaurants_url, options
      log response, options
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
