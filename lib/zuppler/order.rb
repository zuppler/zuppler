module Zuppler
  class Order < Model
    include ActiveAttr::Model

    attribute :uuid
    attribute :reason
    attribute :time
    attribute :duration
    attribute :sender

    validates_presence_of :uuid

    def self.find(uuid)
      Zuppler::Order.new :uuid => uuid
    end

    def confirm(options = {})
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update confirm_url, order_attributes, {}
      success? response
    end

    def cancel(options = {})
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update cancel_url, order_attributes, {}
      success? response
    end

    def miss(options = {})
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update miss_url, order_attributes, {}
      success? response
    end

    def notify(type, options)
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update notification_url(type), order_attributes, {}
      success? response
    end

    private

    def method_missing(m, *args, &blk)
      if @order.nil?
        response = execute_get order_url, {}, {}
        if success? response
          @order = Hashie::Mash.new response['order']
        else
          raise 'orders#show failed.'
        end
      end
      @order.send m, args, &blk
    end

    def success?(response)
      response.success? and response['success'] == true
    end

    def update_attributes(options)
      options.each do |key, value|
        send "#{key}=", value
      end
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
    def order_url
      "#{resource_url}.json"
    end
    def notification_url(type)
      "#{resource_url}/notifications/#{type}/execute.json"
    end

    def resource_url
      "#{Zuppler.secure_url}/orders/#{uuid}"
    end
  end
end
