module Zuppler
  class Request
    include HTTParty

    attr_reader :url, :payload, :headers

    def initialize(url, payload, headers)
      @url = url
      @payload = payload
      @headers = headers
    end

    def execute_update(model, &ablock)
      execute model, :update, &ablock
    end

    private

    def execute(model, verb, &_ablock)
      response = model.send "execute_#{verb}", url, payload, headers
      success = model.v4_success? response
      yield success, self, response if block_given?
      success
    end
  end
end
