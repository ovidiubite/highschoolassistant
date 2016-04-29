class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  validates_presence_of :role
  validates_length_of :email, maximum: 100

  def user?
    role.name == 'user'
  end

  def admin?
    role.name == 'admin'
  end
end
