module Api
  module V1
    class PullRequestsController < ApiApplicationController
      respond_to :json

      def create
        @pull_request = pull_request_creator.create
      end

      private

      def pull_request_params
        params.require(:pull_request).permit(:url, :title).tap do |params|
          params[:author] = current_user
        end
      end

      def pull_request_creator
        PullRequests::PullRequestCreator.new(pull_request_params)
      end
    end
  end
end
