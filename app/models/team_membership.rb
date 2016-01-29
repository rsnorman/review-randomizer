# Models memberships for teams
class TeamMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  has_many :review_assignments

  validates(
    :handle,
    presence: true,
    if: proc { |membership| membership.user_id.nil? }
  )
  validates(
    :user,
    presence: true,
    if: proc { |membership| membership.handle.nil? }
  )

  scope :only_team_mates, -> (user) { where.not(user: user) }
end
