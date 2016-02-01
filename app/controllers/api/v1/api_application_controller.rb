module Api
  module V1
    # Base controller for API
    class ApiApplicationController < ApplicationController
      include SecureFind

      protect_from_forgery with: :null_session

      skip_before_action :authenticate_user!
      before_action :set_company_from_token!, :set_user_from_handle!

      rescue_from CanCan::AccessDenied do |_exception|
        render nothing: true, status: 404
      end

      def current_user
        @user
      end

      private

      def set_company_from_token!
        @company = secure_find_resource_by(Company, :token, company_token)
        render nothing: true, status: :unauthorized unless @company
      end

      def set_user_from_handle!
        @user   = @company.users.find_by(handle: user_handle)
        @user ||= unregistered_user
        render nothing: true, status: :unauthorized unless @user
      end

      def company_token
        request.headers['HTTP_TOKEN']
      end

      def user_handle
        request.headers['HTTP_HANDLE']
      end

      def unregistered_user
        team_membership =
          TeamMembership.find_by(handle: user_handle, team: @company.teams)
        return nil unless team_membership
        Users::UnregisteredUser.new(team_membership)
      end
    end
  end
end
