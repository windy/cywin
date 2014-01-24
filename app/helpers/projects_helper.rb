module ProjectsHelper
  def active_for(stage, dst)
    stage == dst ? 'active' : ''
  end
end
