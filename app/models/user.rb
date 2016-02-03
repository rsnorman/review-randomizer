# User model including authentication junk
class User < ActiveRecord::Base
  ADMIN_ROLE = 'Admin'.freeze

  validates :name,     presence: true
  validates :email,    presence: true
  validates :company,  presence: true, unless: :admin?

  belongs_to :company

  has_many :repos,         foreign_key: :owner_id,  dependent: :destroy
  has_many :pull_requests, foreign_key: :author_id, dependent: :destroy
  has_many :team_memberships,                       dependent: :destroy
  has_many :teams, through: :team_memberships,      dependent: :destroy
  has_many(
    :review_assignments,
    through: :team_memberships,
    class_name: 'ReviewAssignment'
  )

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :set_company

  def set_company
    return unless email
    self.company ||= Company.find_by(domain: email.split('@').last)
  end

  def admin?
    role == ADMIN_ROLE
  end

  def unregistered?
    false
  end
end
