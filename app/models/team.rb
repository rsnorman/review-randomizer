class Team < ActiveRecord::Base
  belongs_to :leader, class_name: User

  validates :name,   presence: true
  validates :leader, presence: true
end
