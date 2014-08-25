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

    def notification(type)
      Zuppler::Notification.new self, type
    end

    def details
      if @details.nil?
        response = execute_get order_url, {}, {}
        if v4_success? response
          @details = Hashie::Mash.new response['order']
        else
          raise 'orders#details failed.'
        end
      end
      @details
    end

    def resource_url
      "#{Zuppler.secure_url}/orders/#{uuid}"
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
    def order_url
      "#{resource_url}.json"
    end
  end
end
