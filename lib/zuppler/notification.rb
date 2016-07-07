module Zuppler
  class Notification < Model
    include ActiveAttr::Model

    attribute :sender

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
      success = false

      Retriable.retriable on: Zuppler::RetryError, base_interval: 1 do
        response = execute_update notification_url('confirm'), attributes, {}
        if v4_success? response
          success = true
        elsif v4_response_code(response) >= 500
          raise Zuppler::RetryError, response.message
        else
          raise Zuppler::ServerError, response.message
        end
      end
      success
    end

    private

    def notification_url(action)
      "#{@order.resource_url}/notifications/#{@type}/#{action}.json"
    end
  end
end
