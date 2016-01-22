class Repo < ActiveRecord::Base
  validates :name,     presence: true, uniqueness: { scope: :company }
  validates :company,  presence: true, uniqueness: true
  validates :url,      presence: true, uniqueness: true
  validates :owner,    presence: true

  belongs_to :owner, class_name: User
end
