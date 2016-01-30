# Models pull requests in a repo
class PullRequest < ActiveRecord::Base
  belongs_to :repo
  belongs_to :author, class_name: 'User'

  has_many :review_assignments
  has_many :users, through: :review_assignments

  validates :repo,    presence: true
  validates :title,   presence: true
  validates :author,  presence: true
  validates :number,  presence: true, uniqueness: { scope: :repo_id }

  attr_accessor :url
end
