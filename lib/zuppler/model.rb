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
        return if Zuppler.logger.nil?

        Zuppler.logger.info ''
        Zuppler.logger.info " ***** Zuppler Url: #{url}"
        Zuppler.logger.debug " ***** Zuppler Request: #{options}"
        Zuppler.logger.debug " ***** Zuppler Response: #{response.body}"
      end
    end

    def log(url, response, options)
      self.class.log url, response, options
    end

    def persisted?
      !new?
    end

    def new?
      id.blank?
    end

    def self.v4_response_code(response)
      response['status']['code'].to_i
    end

    def v4_response_code(response)
      self.class.v4_response_code response
    end

    def self.v4_success?(response)
      response.success? && response['success'] == true
    end

    def v4_success?(response)
      self.class.v4_success? response
    end

    def self.v3_success?(response)
      response.success? && response['success'] == true
    end

    def v3_success?(response)
      self.class.v3_success? response
    end

    def self.v3_response_code(response)
      response['error']['code'].to_i
    end

    def v3_response_code(response)
      self.class.v3_response_code response
    end

    def handle(response, version = 'v3')
      success = send "#{version}_success?", response

      # errors = response['error'] || response['errors'] || []
      # errors.each do |k, v|
      #   errors.add k, v
      # end unless success

      success
    end

    def self.success?(response)
      response.success? && response['valid'] == true
    end

    def success?(response)
      self.class.success? response
    end

    def execute_post(url, body, headers = {})
      options = { body: body, headers: headers }
      response = self.class.post url, options
      log url, response, options
      response
    end

    def execute_update(url, body, headers = {})
      options = { body: body, headers: headers }
      response = self.class.put url, options
      log url, response, options
      response
    end

    def execute_get(url, body, headers = {})
      options = { body: body, headers: headers }
      response = self.class.get url, options
      log url, response, options
      response
    end

    def self.execute_find(url, headers = {})
      options = { headers: headers }
      response = get url, options
      log url, response, options
      response
    end

    def update_attributes(options)
      options.each do |key, value|
        send "#{key}=", value
      end
    end

    def filter_attributes(attrs, *keys)
      attrs.reject { |k, v| keys.include?(k) || v.nil? }
    end
  end
end
