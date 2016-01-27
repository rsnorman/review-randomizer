# Models repositories including validations
class Repo < ActiveRecord::Base
  validates :name,     presence: true, uniqueness: { scope: :company_id }
  validates :url,      presence: true, uniqueness: true
  validates :owner,    presence: true
  validates :company,  presence: true

  belongs_to :company
  belongs_to :owner, class_name: User

  has_and_belongs_to_many :teams # rubocop:disable Rails/HasAndBelongsToMany

  has_many :pull_requests
end
