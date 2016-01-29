# Controller for pull requests
class PullRequestsController < ApplicationController
  respond_to :html, :json

  def new
    @pull_request = PullRequest.new
  end

  def create
    @pull_request =
      PullRequests::PullRequestCreator.new(pull_request_params).create
    respond_with @pull_request.repo, @pull_request
  end

  private

  def pull_request_params
    params.require(:pull_request).permit(:url, :title).tap do |params|
      params[:author] = current_user
    end
  end
end
