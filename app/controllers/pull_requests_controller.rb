# Controller for pull requests
class PullRequestsController < ApplicationController
  respond_to :html, :json

  def create
    @pull_request.save
    respond_with @repo, @pull_request
  end

  private

  def pull_request_params
    params.require(:pull_request).permit(:url, :title)
  end
end
