class TalksMailer < ActionMailer::Base

  domain = ENV['DOMAIN_NAME'] || 'example.com'
  default from: "no-reply@#{domain}"

  def project_talk(user_id, project_id)
    @user = User.find(user_id)
    @project = Project.find(project_id)

    mail from: @user.email, to: @project.owner.email, subject: '有人对你的项目发起了融资约谈邀请'
  end

  def lead_talk(user_id, money_require_id)
    @user = User.find(user_id)
    @money_require = MoneyRequire.find(money_require_id)
    @project = @money_require.project

    mail from: @user.email, to: @project.owner.email, subject: '有人想领投你的项目'
  end

  def work_talk(user_id, project_id)
    @user = User.find(user_id)
    @project = Project.find(project_id)

    mail from: @user.email, to: @project.owner.email, subject: '有人对你的工作职位发起了约谈邀请'
  end

  def talk(user_id, to)
    @user = User.find(user_id)

    mail from: @user.email, to: to, subject: '有人想与你约谈'
  end
end
