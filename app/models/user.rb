class User < ActiveRecord::Base
  resourcify

  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :create_user_profile

  after_create :assign_role!

  has_one :profile, dependent: :destroy

  has_many :orders, dependent: :destroy

  accepts_nested_attributes_for :profile

  delegate :first_name, :last_name, to: :profile, allow_nil: true, controller: :profile

  def create_user_profile
    return if profile.present?
    profile = build_profile
    profile.save(validates: false)
  end

  def assign_role!
    # first user - Lunch Admin
    if User.count==1
      add_role(:admin)
    else
      add_role(:user)
    end
  end
end
