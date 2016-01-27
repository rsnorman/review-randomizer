# Models the top level resource for a company
class Company < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'

  has_many :teams
  has_many :users
  has_many :repos

  validates :name,    presence: true
  validates :domain,  presence: true, uniqueness: true
  validates :token,   presence: true, uniqueness: true
  validates :owner,   presence: true

  before_validation :set_token

  private

  def set_token
    self.token = SecureRandom.uuid
  end
end
