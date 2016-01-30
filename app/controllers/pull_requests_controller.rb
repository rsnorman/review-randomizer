# Controller for pull requests
class PullRequestsController < ApplicationController
  respond_to :html, :json

  rescue_from ReviewRandomizerError do |exception|
    flash[:alert] = exception.message
    @pull_request = PullRequest.new(pull_request_params)
    render :new
  end

  def new
    @pull_request = PullRequest.new
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
end
