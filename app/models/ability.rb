# Authorizations class for the whole review randomizer
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.admin?
      can :manage, :all
    else
      can :create,  Repo
      can :read,    Repo, owner_id: user.id
      can :update,  Repo, owner_id: user.id
      can :destroy, Repo, owner_id: user.id

      can :create,  Team
      can :read,    Team, leader_id: user.id
      can :update,  Team, leader_id: user.id
      can :destroy, Team, leader_id: user.id
    end
  end
end
