# Controller for pull requests in a repo
class RepoPullRequestsController < ApplicationController
  respond_to :html, :json

  load_and_authorize_resource :repo, through: :current_company

  before_action :set_pull_request,  except: :index
  before_action :set_pull_requests, only: :index

  def create
    @pull_request.save
    respond_with @repo, @pull_request
  end

  def update
    @pull_request.update(pull_request_params)
    respond_with @repo, @pull_request
  end

  def destroy
    @pull_request.destroy
    respond_with @repo, @pull_request
  end

  private

  def set_pull_request
    @pull_request =
      if params[:id]
        @repo.pull_requests.find(params[:id])
      elsif params[:action] == 'new'
        @repo.pull_requests.build
      else
        @repo.pull_requests.build(pull_request_params)
      end
  end

  def set_pull_requests
    @pull_requests = @repo.pull_requests
  end

  def pull_request_params
    params
      .require(:pull_request)
      .permit(:repo_id, :title, :number).tap do |params|
        params[:author] = current_user
      end
  end

end
