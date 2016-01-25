# Models pull requests in a repo
class PullRequest < ActiveRecord::Base
  belongs_to :repo

  validates :repo,    presence: true
  validates :title,   presence: true
  validates :number,  presence: true, uniqueness: { scope: :repo_id }
end
