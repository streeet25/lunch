class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, [Profile], user_id: user.id

    can :manage, :all if user.has_role? :admin

    can [:create, :read], Order if user.has_role? :user
  end
end
