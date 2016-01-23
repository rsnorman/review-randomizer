# User model including authentication junk
class User < ActiveRecord::Base
  ADMIN_ROLE = 'Admin'.freeze

  has_many :repos, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    role == ADMIN_ROLE
  end
end
