class Ability
  include CanCan::Ability

  def initialize(user, params)
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
      can :create, Investment

      can [ :leader_confirm ], MoneyRequire do |money_require|
        money_require.leader_id == user.investor.try(:id)
      end
    end

    # register user
    if user.id
      #项目权限
      can [:edit, :stage1, :stage2, :publish,:invite] , Project do |project|
        project.owner.try(:id) == user.id
      end
      can [:create], Project

      can [:new, :create], MoneyRequire do
        if project_id = params.require(:money_require).permit(:project_id)[:project_id]
          project = Project.find(project_id)
          project.owner.try(:id) == user.id
        else
          false
        end
      end

      can [:add_leader, :close], MoneyRequire do |money_require|
        money_require.project.owner.try(:id) == user.id
      end
    end

    # guest
    can [:index, :show], Project
  end
end
