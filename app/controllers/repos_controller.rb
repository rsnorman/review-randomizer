# Controllers for repositories that will have PRs opened against it
class ReposController < ApplicationController
  respond_to :html

  load_and_authorize_resource through: :current_company

  def create
    @repo.save
    respond_with @repo
  end

  def update
    @repo.update(repo_params)
    respond_with @repo
  end

  def destroy
    @repo.destroy
    respond_with @repo
  end

  private

  def repo_params
    params.require(:repo).permit(
      :organization, :name, :description, :url
    ).tap do |params|
      params[:owner] = current_user
    end
  end
end
