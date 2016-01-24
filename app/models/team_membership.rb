# Models memberships for teams
class TeamMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

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
end
