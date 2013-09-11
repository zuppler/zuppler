module Zuppler
  class Menu
    include ActiveAttr::Model, HTTParty
    
    attribute :restaurant
    attribute :id
    attribute :name
    attribute :special, default: true

    def save
      menu_attributes = self.attributes.reject{|k,v| ['restaurant'].include?(k) or v.nil?}
      options = {:body => {:menu => menu_attributes}}
      response = self.class.post menus_url, options
      log response, options
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
    
    def log(response, options)
      puts "\n"
      puts " ***** Request: #{options}"
      puts " ***** Response: #{response.body}"
    end

    def menus_url
      "#{Zuppler.api_url}/restaurants/#{restaurant.permalink}/menus.json"
    end
    
    def success?(response)
      response.success? and response['valid'] == true
    end
  end
end
