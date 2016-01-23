# Controller for teams tied to repos and contains users
class TeamsController < ApplicationController
  respond_to :html, :json
  load_and_authorize_resource

  # POST /teams
  # POST /teams.json
  def create
    @team.save
    respond_with @team
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    @team.update(team_params)
    respond_with @team
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_with @team
  end

  private

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def team_params
    params.require(:team).permit(:name, repo_ids: []).tap do |params|
      params[:leader_id] = current_user.id
    end
  end
end
