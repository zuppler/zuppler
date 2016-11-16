module Zuppler
  class Request
    include HTTParty

    attr_reader :url, :body, :headers

    def initialize(url, body, headers)
      @url = url
      @body = body
      @headers = headers
    end

    def execute_read(model, &ablock)
      execute model, :get, &ablock
    end

    def execute_update(model, &ablock)
      execute model, :update, &ablock
    end

    private

    def execute(model, verb, &_ablock)
      response = model.send "execute_#{verb}", url, body, headers
      success = model.v4_success? response
      yield success, self, response if block_given?
      response
    end
  end

  module Requestable
    def request(url, body, headers = request_headers)
      Zuppler::Request.new url, body, headers
    end
  end
end
