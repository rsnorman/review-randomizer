module Api
  module V1
    class ApiApplicationController < ApplicationController
      include SecureFind

      protect_from_forgery with: :null_session

      skip_before_action :authenticate_user!
      before_action :set_company_from_token!, :set_user_from_handle!

      def current_user
        @user
      end

      private

      def set_company_from_token!
        @company = find_resource_by(Company, :token, company_token)
        render nothing: true, status: :unauthorized unless @company
      end

      def set_user_from_handle!
        @user = find_resource_by(User, :handle, user_handle)
        render nothing: true, status: :unauthorized unless @user
      end

      def company_token
        request.headers['HTTP_TOKEN']
      end

      def user_handle
        request.headers['HTTP_HANDLE']
      end
    end
  end
end
