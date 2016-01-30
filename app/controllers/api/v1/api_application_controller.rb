module Api
  module V1
    class ApiApplicationController < ApplicationController
      protect_from_forgery with: :null_session

      skip_before_action :authenticate_user!
      before_filter :set_company_from_token!, :set_user_from_handle!

      def current_user
        @user
      end

      private

      def set_company_from_token!
        if !company_token
          render nothing: true, status: :unauthorized
        else
          @company = nil
          Company.all.each do |company|
            if Devise.secure_compare(company.token, company_token)
              @company = company
            end
          end
          render nothing: true, status: :unauthorized unless @company
        end
      end

      def set_user_from_handle!
        if !user_handle
          render nothing: true, status: :unauthorized
        else
          @user = nil
          @company.users.each do |user|
            if Devise.secure_compare(user.handle.downcase, user_handle.downcase)
              @user = user
            end
          end
          render nothing: true, status: :unauthorized unless @user
        end
      end

      def company_token
        request.headers['token']
      end

      def user_handle
        request.headers['handle']
      end
    end
  end
end
