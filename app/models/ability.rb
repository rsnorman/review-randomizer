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
    end
  end

  private

  attr_accessor :user

  def add_owner_rules(subject, owner_type)
    can :create,  subject
    can :read,    subject, "#{owner_type}_id".to_sym => user.id
    can :update,  subject, "#{owner_type}_id".to_sym => user.id
    can :destroy, subject, "#{owner_type}_id".to_sym => user.id
  end
end
