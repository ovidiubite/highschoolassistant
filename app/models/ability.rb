class Ability
  include CanCan::Ability

  def initialize(user)
    # if user.present?
    #   if user.admin?
    #     can :manage, Admin
    #   elsif user.user?
    #     can :manage, :all
    #     cannot :manage, Admin
    #   end
    # else
    #   can :manage, :all
    #   cannot :manage, Admin
    # end
  end
end
