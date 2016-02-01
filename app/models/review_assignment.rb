# Models assignments for reviewing pull requests
class ReviewAssignment < ActiveRecord::Base
  belongs_to :pull_request
  belongs_to :team_membership
  has_one :team, through: :team_membership
  has_one :user, through: :team_membership

  validates :pull_request,    presence: true
  validates :team_membership, presence: true

  def assignee_handle
    user ? user.handle : team_membership.handle
  end
end
