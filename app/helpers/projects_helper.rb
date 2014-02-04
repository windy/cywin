module ProjectsHelper
  def active_for(stage, dst)
    stage == dst ? 'active' : ''
  end

  def all_district(projects)
    projects.collect do |p|
      if p.where2 == '110100'
        [ p.where2, '北京市' ]
      else
        [ p.where2, ChinaCity.get(p.where2) ]
      end
    end.uniq
  end

  def project_address(p)
    where1 = ( ChinaCity.get(p.where1) rescue p.where1 )
    where2 = ( ChinaCity.get(p.where2) rescue p.where2 )
    "#{where1} * #{where2}"
  end
end
