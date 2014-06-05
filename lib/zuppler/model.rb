module Zuppler
  module Macros
    def self.included(mod)
      class << mod
        alias_method :original_create, :create

        def create(options = {})
          Zuppler.check
          original_create options
        end
      end
    end
  end

  class Model
    include HTTParty
    attr_writer :restaurant_id

    class << self
      def log(url, response, options)
        puts
        puts " ***** Zuppler Url: #{url}"
        puts " ***** Zuppler Request: #{options}"
        puts " ***** Zuppler Response: #{response.body}"
      end
    end

    def log(url, response, options)
      self.class.log url, response, options
    end

    def persisted?
      !!self.id
    end

    def new?
      self.id.blank?
    end

    def self.v3_success?(response)
      response.success? and response['success'] == true
    end
    def v3_success?(response)
      self.class.v3_success? response
    end

    def self.success?(response)
      response.success? and response['valid'] == true
    end
    def success?(response)
      self.class.success? response
    end

    def execute_create(url, body, headers = {})
      options = {:body => body, :headers => headers}
      response = self.class.post url, options
      log url, response, options
      response
    end
    def execute_update(url, body, headers = {})
      options = {:body => body, :headers => headers}
      response = self.class.put url, options
      log url, response, options
      response
    end
    def execute_get(url, body, headers = {})
      options = {:body => body, :headers => headers}
      response = self.class.get url, options
      log url, response, options
      response
    end
    def self.execute_find(url, headers = {})
      options = {:headers => headers}
      response = get url, options
      log url, response, options
      response
    end

    def filter_attributes(attrs, *keys)
      attrs.reject{|k,v| keys.include?(k) or v.nil?}
    end
  end
end
