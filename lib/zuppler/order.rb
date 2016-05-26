module Zuppler
  class Order < Model
    include ActiveAttr::Model

    attribute :uuid
    attribute :reason
    attribute :time
    attribute :duration
    attribute :sender
    attribute :metadata

    validates_presence_of :uuid

    def self.find(uuid)
      Zuppler::Order.new uuid: uuid
    end

    def confirm(options = {})
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update confirm_url, order_attributes, {}
      v4_success? response
    end

    def cancel(options = {})
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update cancel_url, order_attributes, {}
      v4_success? response
    end

    def miss(options = {})
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update miss_url, order_attributes, {}
      v4_success? response
    end

    def open(options = {})
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update open_url, order_attributes, {}
      JSON.parse response.body
    end

    def close(options = {})
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update close_url, order_attributes, {}
      JSON.parse response.body
    end

    def touch(options = {})
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update touch_url, order_attributes, {}
      JSON.parse response.body
    end

    def save(options = {})
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update order_url, { order: order_attributes }, {}
      v4_success? response
    end

    def notification(type)
      Zuppler::Notification.new self, type
    end

    def details
      if @details.nil?
        Retriable.retriable on: Zuppler::RetryError, base_interval: 1 do
          response = execute_get order_url, {}, {}
          if v4_success? response
            @details = Hashie::Mash.new response['order']
          else
            if v4_response_code(response) > 500
              raise Zuppler::RetryError, response.message
            else
              raise Zuppler::ServerError, response.message
            end
          end
        end
      end
      @details
    end

    def resource_url
      "#{Zuppler.orders_api_url}/orders/#{uuid}"
    end

    private

    def confirm_url
      "#{resource_url}/confirm.json"
    end

    def cancel_url
      "#{resource_url}/cancel.json"
    end

    def miss_url
      "#{resource_url}/miss.json"
    end

    def open_url
      "#{resource_url}/open.json"
    end

    def close_url
      "#{resource_url}/close.json"
    end

    def touch_url
      "#{resource_url}/touch.json"
    end

    def order_url
      "#{resource_url}.json"
    end
  end
end
