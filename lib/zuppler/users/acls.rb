module Zuppler
  module Users
    module Acls
      def acls(param = nil)
        param ? details.acls[param] : details.acls
      end

      def grant(user_id, options = {})
        response = execute_update user_grant_url(user_id), { acls: options }, request_headers
        v4_success? response
      end

      def revoke(user_id, options = {})
        response = execute_update user_revoke_url(user_id), { acls: options }, request_headers
        v4_success? response
      end

      private

      def user_grant_url(user_id)
        "#{Zuppler.users_api_url}/users/#{id}/grant.json"
      end

      def user_revoke_url(user_id)
        "#{Zuppler.users_api_url}/users/#{id}/revoke.json"
      end
    end
  end
end
