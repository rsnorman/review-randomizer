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
    end
  end
end
