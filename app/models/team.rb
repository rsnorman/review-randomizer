# Team full of users assigned to repos
class Team < ActiveRecord::Base
  validates :name,     presence: true
  validates :leader,   presence: true
  validates :company,  presence: true

  belongs_to :company
  belongs_to :leader, class_name: User

  has_and_belongs_to_many :repos # rubocop:disable Rails/HasAndBelongsToMany

  has_many :team_memberships
  has_many :users, through: :team_memberships

  def team_mates_for(user)
    team_memberships.select { |tm| tm.user_id != user.id }
  end
end
