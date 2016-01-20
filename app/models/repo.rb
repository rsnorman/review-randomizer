class Repo < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { scope: :company }
  validates :company, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
end
