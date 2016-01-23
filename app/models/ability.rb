# Authorizations class for the whole review randomizer
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.admin?
      can :manage, :all
    else
      create_repo_rules
      create_team_rules
    end
  end

  private

  def create_repo_rules
    can :create,  Repo
    can :read,    Repo, owner_id: user.id
    can :update,  Repo, owner_id: user.id
    can :destroy, Repo, owner_id: user.id
  end

  def create_team_rules
    can :create,  Team
    can :read,    Team, leader_id: user.id
    can :update,  Team, leader_id: user.id
    can :destroy, Team, leader_id: user.id
  end
end
