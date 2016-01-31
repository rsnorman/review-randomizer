# Authorizations class for the whole review randomizer
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    @user = user

    if user.admin?
      can :manage, :all
    else
      create_user_abilities
    end
  end

  private

  attr_accessor :user

  def create_user_abilities
    create_repo_abilities
    create_team_abilities
    create_team_membership_abilities
    create_pull_request_abilities
    create_review_assignment_abilities
  end

  def create_repo_abilities
    can :create,  Repo
    can :read,    Repo, company_id: user.company_id
    can :update,  Repo, owner_id:   user.id
    can :destroy, Repo, owner_id:   user.id
  end

  def create_team_abilities
    can :create,  Team
    can :read,    Team, company_id: user.company_id
    can :update,  Team, leader_id:  user.id
    can :destroy, Team, leader_id:  user.id
  end

  def create_pull_request_abilities
    can :create,  PullRequest
    can :read,    PullRequest, repo: { company_id: user.company_id }
    can :update,  PullRequest, author_id: user.id
    can :destroy, PullRequest, author_id: user.id
    can :update,  PullRequest, repo: { owner_id: user.id }
    can :destroy, PullRequest, repo: { owner_id: user.id }
  end

  def create_team_membership_abilities
    can :create,  TeamMembership, team: { leader_id: user.id }
    can :read,    TeamMembership, team: { company_id: user.company_id }
    can :update,  TeamMembership, team: { leader_id: user.id }
    can :destroy, TeamMembership, team: { leader_id: user.id }
  end

  def create_review_assignment_abilities
    can :create,  ReviewAssignment
    can :read,    ReviewAssignment, team: { company_id: user.company_id }
    can :update,  ReviewAssignment, team: { leader_id: user.id }
    can :destroy, ReviewAssignment, team_membership: { team: { leader_id: user.id } }
    can :update,  ReviewAssignment, pull_request: { author_id: user.id }
    can :destroy, ReviewAssignment, pull_request: { author_id: user.id }
  end
end
