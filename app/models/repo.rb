# Models repositories including validations
class Repo < ActiveRecord::Base
  validates :name,     presence: true, uniqueness: { scope: :company }
  validates :company,  presence: true, uniqueness: true
  validates :url,      presence: true, uniqueness: true
  validates :owner,    presence: true

  belongs_to :owner, class_name: User
  has_and_belongs_to_many :teams # rubocop:disable Rails/HasAndBelongsToMany
end
