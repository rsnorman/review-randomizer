# Controller for managing team memberships
class TeamMembershipsController < ApplicationController
  respond_to :html

  load_and_authorize_resource :team,            through: :current_company
  load_and_authorize_resource :team_membership, through: :team

  def create
    @team_membership.save
    respond_with @team, @team_membership
  end

  def update
    @team_membership.update(team_membership_params)
    respond_with @team, @team_membership
  end

  def destroy
    @team_membership.destroy
    respond_with @team, @team_membership
  end

  private

  def team_membership_params
    params.require(:team_membership).permit(:handle, :user_id)
  end
end
