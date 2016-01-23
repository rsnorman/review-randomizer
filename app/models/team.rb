# Team full of users assigned to repos
class Team < ActiveRecord::Base
  validates :name,   presence: true
  validates :leader, presence: true

  belongs_to :leader, class_name: User
  has_and_belongs_to_many :repos # rubocop:disable Rails/HasAndBelongsToMany
end
