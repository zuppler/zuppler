module Zuppler
  module Users
    module Zupps
      def reward_points(amount, &ablock)
        request = request reward_zupps_url, points: { amount: amount }
        response = request.execute_update self, &ablock
        response.success?
      end

      def revoke_points(amount, &ablock)
        request = request revoke_zupps_url, points: { amount: amount }
        response = request.execute_update self, &ablock
        response.success?
      end

      def reward_bucks(amount, restaurant_id, &ablock)
        payload = { bucks: { restaurant_id: restaurant_id, amount: amount } }
        request = request reward_zupps_url, payload
        response = request.execute_update self, &ablock
        response.success?
      end

      def revoke_bucks(amount, restaurant_id, &ablock)
        payload = { bucks: { restaurant_id: restaurant_id, amount: amount } }
        request = request revoke_zupps_url, payload
        response = request.execute_update self, &ablock
        response.success?
      end

      private

      def reward_zupps_url
        "#{Zuppler.users_api_url}/users/#{id}/zupps_reward.json"
      end

      def revoke_zupps_url
        "#{Zuppler.users_api_url}/users/#{id}/zupps_revoke.json"
      end
    end
  end
end
