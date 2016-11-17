module Zuppler
  module Users
    module Roles
      def role?(role)
        details.roles.include? role
      end

      def user?
        details.roles.empty?
      end

      def channel?
        role? 'channel'
      end

      def restaurant?
        role? 'restaurant'
      end

      def restaurant_staff?
        role? 'restaurant_staff'
      end

      def ambassador?
        role? 'ambassador'
      end

      def config?
        role? 'config'
      end

      def support?
        role? 'support'
      end

      def admin?
        role? 'admin'
      end
    end
  end
end
