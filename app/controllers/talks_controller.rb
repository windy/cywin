class TalksController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def talk_content
    @user = current_user
    case params[:type]
    when 'project_talk'
      @project = Project.find(params[:target_id])
      render 'talks_mailer/project_talk', layout: false
    when 'lead_talk'
      @money_require = MoneyRequire.find(params[:target_id])
      @project = @money_require.project
      render 'talks_mailer/lead_talk', layout: false
    when 'work_talk'
      render 'talks_mailer/work_talk', layout: false
    else
      raise "unknown type: #{params[:type]}"
    end
  end

  def create
    @talk = Talk.new(user: current_user)
    case params[:type]
    when 'project_talk'
      @project = Project.find(params[:target_id])
      @talk.target = @project
    when 'lead_talk'
      @money_require = MoneyRequire.find(params[:target_id])
      @talk.target = @money_require
    when 'work_talk'
      #TODO
    else
      raise "unknown type: #{params[:type]}"
    end

    @talk.save!
    render_success
  end

end
