class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy

  after_create :create_user_profile

  after_create :assign_role

  accepts_nested_attributes_for :profile

  delegate :first_name, :last_name, to: :profile, allow_nil: true, controller: :profile

  def create_user_profile
    profile = build_profile
    profile.save(validates: false)
  end


  def assign_role
    # first user - Lunch Admin
    if User.count==0
      add_role(:admin)
    else
      add_role(:user)
    end
  end
end
