class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    end

    if user.has_role? :leader
      can :read, Project
    end

    if user.has_role? :investor
      can :read, Project do
        #TODO 项目的公开程度字段判定
      end
      can :create, Syndicate
    end

    can [:edit, :stage1, :stage2, :publish, :invest, :close_investment, :invite] , Project do |project|
      project.owner.try(:id) == user.id
    end

    # register user
    if user.id
      can [:create], Project
    end

    # guest
    can [:index, :show], Project
  end
end
