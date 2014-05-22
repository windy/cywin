class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
    end

    if user.has_role? :investor
      can :create, Investment
      can :update, Investment do |investment|
        investment.user == user && investment.money_require.opened?
      end

      can [ :leader_confirm ], MoneyRequire do |money_require|
        money_require.leader_id && money_require.leader_id == user.try(:id)
      end
    end

    # register user
    if user.id
      #项目权限
      can [:update], Project do |project|
        project.owner.try(:id) == user.id
      end
      can [:create], Project

      can [:update], MoneyRequire do |money_require|
        project = money_require.project
        project.owner.try(:id) == user.id
      end

      can [:update], User do |s|
        s.id == user.id
      end
    end

    # guest
  end
end
