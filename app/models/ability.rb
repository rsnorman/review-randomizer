# Authorizations class for the whole review randomizer
class Ability
  include CanCan::Ability

  RULES = [
    {
      subject: Repo,
      ownership: { repo: :owner_id, except: :create }
    },
    {
      subject: Team,
      ownership: { team: :leader_id, except: :create }
    },
    {
      subject: TeamMembership,
      ownership: { team: :leader_id }
    },
    {
      subject: PullRequest,
      ownership: { repo: :owner_id }
    },
    {
      subject: ReviewAssignment,
      ownership: { pull_request: :author_id, except: :read }
    }
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
    end
  end

  private

  attr_accessor :user

  def add_owner_rules(subject, ownership)
    skip_ownership_actions = Array(ownership.delete(:except))

    ownership_options = create_ownership_options(subject, ownership)

    %i(read create update destroy).map do |action|
      create_rule(action, subject, ownership_options, skip_ownership_actions)
    end
  end

  def create_rule(action, subject, ownership_options, skip_ownership_actions)
    can(
      action,
      subject,
      skip_ownership_actions.include?(action) ? {} : ownership_options
    )
  end

  def create_ownership_options(subject, ownership)
    if subject.to_s.underscore.to_sym == ownership.keys.first
      { ownership.values.first => user.id }
    else
      create_nested_ownership_options(ownership)
    end
  end

  def create_nested_ownership_options(ownership)
    {
      ownership.keys.first => {
        ownership.values.first => user.id
      }
    }
  end
end
