class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.admin?
        can :manage, :all
      elsif user.user?
        can :read, :all
        can :manage, User
        cannot [:destroy, :create, :new], User
      end
    else
      can :read, :all
    end
  end
end
