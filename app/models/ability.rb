class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, [Profile], user_id: user.id

    if user.has_role? :admin
      can :manage, :all
    end

    if user.has_role? :user
      can [:create,:read], Order
    end
  end

end
