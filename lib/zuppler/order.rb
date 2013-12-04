module Zuppler
  class Order < Model
    include ActiveAttr::Model

    attribute :uuid
    attribute :message
    attribute :time

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

    def reject(options = {})
      update_attributes options
      order_attributes = filter_attributes attributes, 'uuid'
      response = execute_update reject_url, order_attributes, {}
      success? response
    end

    protected

    def success?(response)
      response.success? and response['success'] == true
    end

    def update_attributes(options)
      options.each do |key, value|
        send "#{key}=", value
      end
    end

    def confirm_url
      "#{order_url}/confirm"
    end

    def reject_url
      "#{order_url}/reject"
    end

    def order_url
      "#{Zuppler.secure_url}/orders/#{uuid}"
    end
  end
end
