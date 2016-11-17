module Zuppler
  module Users
    module Prints
      def print_params
        if @print_params.nil?
          response = execute_get user_print_params_url, {}, request_headers
          if v4_success? response
            @print_params = Hashie::Mash.new response['print_params']
          end
        end
        @print_params
      end

      def update_print_params(print_params)
        response = execute_update user_print_params_url, { print_params: print_params }, request_headers
        v4_success? response
      end

      private

      def user_print_params_url
        "#{Zuppler.users_api_url}/users/#{id}/print_params.json"
      end
    end
  end
end
