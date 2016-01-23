# User model including authentication junk
class User < ActiveRecord::Base
  ADMIN_ROLE = 'Admin'.freeze

  validates :name,      presence: true
  validates :email,     presence: true
  validates :password,  presence: true

  has_many :repos, dependent: :destroy
  has_many :teams, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    role == ADMIN_ROLE
  end
end
