class PullRequestsController < ApplicationController
  respond_to :html, :json

  load_resource :repo
  load_and_authorize_resource :pull_request, through: :repo

  def create
    @pull_request.save
    respond_with @pull_request
  end

  def update
    @pull_request.update(pull_request_params)
    respond_with @pull_request
  end

  def destroy
    @pull_request.destroy
    respond_with @pull_request
  end

  private

  def pull_request_params
    params.require(:pull_request).permit(:repo_id, :title, :number)
  end
end
