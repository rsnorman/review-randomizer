module Api
  module V1
    class PullRequestsController < ApiApplicationController
      respond_to :json

      rescue_from PullRequests::UrlParser::MissingRepo do |_exception|
        render nothing: true, status: 404
      end

      def create
        @pull_request = create_pull_request
      end

      private

      def pull_request_params
        params.require(:pull_request).permit(:url, :title).tap do |params|
          params[:author] = current_user
        end
      end

      def create_pull_request
        if (pull_request = find_pull_request_from_url)
          pull_request
        else
          pull_request_creator.create
        end
      end

      def pull_request_creator
        PullRequests::PullRequestCreator.new(pull_request_params)
      end

      def find_pull_request_from_url
        PullRequests::UrlPullRequest.find_by_url(pull_request_params[:url])
      end
    end
  end
end
