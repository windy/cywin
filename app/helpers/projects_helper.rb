module ProjectsHelper
  def active_for(stage, dst)
    stage == dst ? 'active' : ''
  end

  def all_district(projects)
    projects.collect do |p|
      if p.where2 == '110100'
        '北京市'
      else
        ChinaCity.get(p.where2)
      end
    end.uniq
  end
end
