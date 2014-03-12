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

  def progress_p(money_require)
    "融资进度: #{money_require.progress*100}% / ¥ #{money_require.syndicate_money * 10000} ( ¥ #{money_require.money * 10000} ) / #{(money_require.deadline.to_date - money_require.created_at.to_date).to_i}天 ( 剩余 #{(money_require.deadline.to_date - Time.now.to_date).to_i} 天 )"
  end

  def progress_width(money_require)
    width = (money_require.progress * 100).to_i
    width = 100 if width > 100
    "#{width}%"
  end
end
