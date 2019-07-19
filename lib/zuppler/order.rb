module Zuppler
  class Order < Model
    include ActiveAttr::Model

    attribute :uuid
    attribute :reason
    attribute :time
    attribute :duration
    attribute :sender
    attribute :metadata
    attribute :force
    attribute :tip
    attribute :total
    attribute :type

    validates_presence_of :uuid

    def self.find(uuid)
      Zuppler::Order.new uuid: uuid
    end

    def create_adjustment(options = {})
      update_attributes options
      order_adjustment_attributes = filter_attributes attributes, 'uuid'
      response = execute_update order_adjustment_url, order_adjustment_attributes, {}
      v4_success? response
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

    def prepare(options = {})
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update prepare_url, order_attributes, {}
      v4_success? response
    end

    def pickup(options = {})
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update pickup_url, order_attributes, {}
      v4_success? response
    end

    def delivery(options = {})
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update delivery_url, order_attributes, {}
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
        response = execute_get order_url, {}, {}
        @details = Hashie::Mash.new(response['order']) if v4_success? response
      end
      @details
    end

    def resource_url
      "#{Zuppler.orders_api_url}/orders/#{uuid}"
    end

    private

    def order_adjustment_url
      "#{resource_url}/create_adjustment.json"
    end

    def confirm_url
      "#{resource_url}/confirm.json"
    end

    def cancel_url
      "#{resource_url}/cancel.json"
    end

    def miss_url
      "#{resource_url}/miss.json"
    end

    def prepare_url
      "#{resource_url}/prepare.json"
    end

    def pickup_url
      "#{resource_url}/picup.json"
    end

    def delivery_url
      "#{resource_url}/delivery.json"
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
