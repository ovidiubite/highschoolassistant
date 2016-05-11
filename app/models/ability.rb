class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.admin?
        can :manage, ActiveAdmin::Page
      elsif user.user?
        can :manage, :all
        cannot :manage, ActiveAdmin::Page
      end
    else
      can :manage, :all
      cannot :manage, ActiveAdmin::Page
    end
  end
end
