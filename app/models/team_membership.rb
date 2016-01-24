class TeamMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  validates :handle, presence: true
end
