# Controllers for repositories that will have PRs opened against it
class ReposController < ApplicationController
  respond_to :html, :json
  load_and_authorize_resource

  # POST /repos
  # POST /repos.json
  def create
    @repo.save
    respond_with @repo
  end

  # PATCH/PUT /repos/1
  # PATCH/PUT /repos/1.json
  def update
    @repo.update(repo_params)
    respond_with @repo
  end

  # DELETE /repos/1
  # DELETE /repos/1.json
  def destroy
    @repo.destroy
    respond_with @repo
  end

  private

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def repo_params
    params.require(:repo).permit(
      :company, :organization, :name, :description, :url
    ).tap do |params|
      params[:owner] = current_user
    end
  end
end
