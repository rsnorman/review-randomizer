# Models pull requests in a repo
class PullRequest < ActiveRecord::Base
  belongs_to :repo
  belongs_to :author, polymorphic: true

  has_many :review_assignments, dependent: :destroy
  has_many :users, through: :review_assignments

  validates :repo,    presence: true
  validates :title,   presence: true
  validates :author,  presence: true
  validates :number,  presence: true, uniqueness: { scope: :repo_id }
end
