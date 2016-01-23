# Authorizations class for the whole review randomizer
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    @user = user

    if user.admin?
      can :manage, :all
    else
      add_owner_rules(Repo, :owner)
      add_owner_rules(Team, :leader)
      add_owner_rules(
        TeamMembership, team: {leader_id: user.id}, scope_create: true
      )
    end
  end

  private

  attr_accessor :user

  def add_owner_rules(subject, ownership_options)
    if ownership_options.is_a?(Symbol)
      ownership_options = {"#{ownership_options}_id".to_sym => user.id}
    else
      scope_create = ownership_options.delete(:scope_create)
    end

    can :create,  subject, scope_create ? ownership_options : {}
    can :read,    subject, ownership_options
    can :update,  subject, ownership_options
    can :destroy, subject, ownership_options
  end
end
