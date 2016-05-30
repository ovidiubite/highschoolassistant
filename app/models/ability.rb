class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    case controller_namespace
      when 'Admin'
        can :manage, :all  if user && user.admin?
      else
        if user && user.user?
          can :manage, :all
          cannot :manage, User
          can [:results_history, :edit, :update], User, :id => user.id
        else
          can :read, :all
          cannot :manage, User
        end
    end
  end
end
