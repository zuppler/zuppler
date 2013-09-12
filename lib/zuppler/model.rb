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
    include ActiveModel::Model, HTTParty

    # extend ActiveModel::Naming
    # include ActiveModel::Conversion
    # include ActiveModel::Serializers::JSON
    # include ActiveModel::Validations
    # include ActiveModel::MassAssignmentSecurity

    define_model_callbacks :create, :all
    
    class << self
      def attribute_keys=(keys)
        @attribute_keys = keys
        attr_accessor(*keys)
      end
      def attribute_keys
        @attribute_keys
      end
      def log(response, options)
        puts "\n"
        puts " ***** Request: #{options}"
        puts " ***** Response: #{response.body}"
      end
    end

    def initialize(attributes={})
      self.attributes = attributes
    end
    def attributes
      self.class.attribute_keys.reduce({}) do |result, key|
        result[key] = read_attribute_for_validation key
        result
      end
    end
    def attributes=(attrs)
      attrs.each do |k, v|
        method = "#{k}="
        send method, v if respond_to? method
      end
    end

    def log(response, options)
      self.class.log response, options
    end

    def persisted?
      !!self.id
    end

    def success?(response)
      response.success? and response['valid'] == true
    end
    def execute_create(url, options)
      response = self.class.post url, options
      log response, options
      response
    end
  end
end
