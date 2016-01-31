# Controller for teams tied to repos and contains users
class TeamsController < ApplicationController
  respond_to :html

  load_and_authorize_resource through: :current_company

  def create
    @team.save
    respond_with @team
  end

  def update
    @team.update(team_params)
    respond_with @team
  end

  def destroy
    @team.destroy
    respond_with @team
  end

  private

  def team_params
    params.require(:team).permit(:name, repo_ids: []).tap do |params|
      params[:leader_id] = current_user.id
    end
  end
end
