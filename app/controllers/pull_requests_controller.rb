# Controller for pull requests
class PullRequestsController < ApplicationController
  respond_to :html

  rescue_from ReviewRandomizerError do |exception|
    flash[:alert] = exception.message
    @pull_request = build_pull_request
    render :new
  end

  def new
    @pull_request = build_pull_request
  end

  def create
    @pull_request = pull_request_creator.create
    respond_with @pull_request.repo, @pull_request
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

  def build_pull_request
    PullRequests::UrlPullRequest.new(PullRequest.new).tap do |pull_request|
      if params.key?(:pull_request)
        pull_request.url        = pull_request_params.delete(:url)
        pull_request.attributes = pull_request_params.except(:url)
      end
    end
  end
end
