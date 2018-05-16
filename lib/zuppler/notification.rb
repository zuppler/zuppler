module Zuppler
  class Notification < Model
    include ActiveAttr::Model

    attribute :sender
    attribute :duration

    def initialize(order, type)
      @order = order
      @type = type
    end

    def execute(options = {})
      update_attributes options
      response = execute_update notification_url('execute'), attributes, {}
      v4_success? response
    end

    def confirm(options = {})
      update_attributes options
      response = execute_update notification_url('confirm'), attributes, {}
      v4_success? response
    end

    private

    def notification_url(action)
      "#{@order.resource_url}/notifications/#{@type}/#{action}.json"
    end
  end
end
