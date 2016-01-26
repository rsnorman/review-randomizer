# Authorizations class for the whole review randomizer
class Ability
  include CanCan::Ability

  RULES = [
    { subject: Repo,             ownership: :owner_id                    },
    { subject: Team,             ownership: :leader_id                   },
    { subject: TeamMembership,   ownership: { team:         :leader_id } },
    { subject: PullRequest,      ownership: { repo:         :owner_id  } }
  ].map(&:freeze).freeze

  def initialize(user)
    return unless user
    @user = user

    if user.admin?
      can :manage, :all
    else
      RULES.each do |rule|
        add_owner_rules(rule[:subject], rule[:ownership])
      end

      can :create,  ReviewAssignment, create_nested_ownership_options(pull_request: :author_id)
      can :read,    ReviewAssignment
      can :update,  ReviewAssignment, create_nested_ownership_options(pull_request: :author_id)
      can :destroy, ReviewAssignment, create_nested_ownership_options(pull_request: :author_id)
    end
  end

  private

  attr_accessor :user

  def add_owner_rules(subject, ownership)
    if ownership.is_a?(Symbol)
      ownership_options = { ownership => user.id }
    else
      ownership_options = create_nested_ownership_options(ownership)
      scope_create = true
    end

    can :create,  subject, scope_create ? ownership_options : {}
    can :read,    subject, ownership_options
    can :update,  subject, ownership_options
    can :destroy, subject, ownership_options
  end

  def create_nested_ownership_options(ownership)
    {
      ownership.keys.first => {
        ownership.values.first => user.id
      }
    }
  end
end
