namespace :demo do
  desc "Setup demo data for the application"
  task setup: :environment do
    puts "Setting up demo data..."
    
    # Create categories and cities if they don't exist
    setup_categories_and_cities
    
    # Create regular users
    regular_users = create_regular_users(5)
    
    # Create investor users
    investor_users = create_investor_users(3)
    
    # Create projects with different categories and cities
    projects = create_projects(regular_users, 8)
    
    # Create team members for projects
    add_team_members_to_projects(projects, regular_users)
    
    # Create money requires for projects
    money_requires = create_money_requires(projects)
    
    # Create person requires for projects
    create_person_requires(projects)
    
    # Create investors and investments
    create_investors_and_investments(investor_users, money_requires)
    
    # Create stars (project followers)
    create_stars(regular_users, projects)
    
    puts "Demo data setup completed!"
  end
  
  private
  
  def setup_categories_and_cities
    # Create categories if they don't exist
    unless Category.count > 0
      puts "Creating categories..."
      YAML.load_file(File.join(Rails.root, 'config', 'default_categories.yml')).each do |head_name, categories|
        h = Head.find_or_create_by(name: head_name)
        categories.each do |category_name|
          c = Category.find_or_create_by(name: category_name)
          c.head = h
          c.save!
        end
      end
    end
    
    # Create cities if they don't exist
    unless City.count > 0
      puts "Creating cities..."
      ['深圳', '上海', '北京', '成都', '西安', '广州', '杭州'].each do |name|
        City.find_or_create_by(name: name)
      end
    end
  end
  
  def create_regular_users(count)
    puts "Creating #{count} regular users..."
    users = []
    
    count.times do |i|
      name = "user_#{i+1}"
      email = "user_#{i+1}@example.com"
      
      user = User.where(email: email).first_or_create(
        name: name,
        password: "password123",
        password_confirmation: "password123",
        description: "这是一个普通用户账号，用于演示系统功能。"
      )
      
      # Skip confirmation to make the account usable immediately
      user.skip_confirmation! if user.respond_to?(:skip_confirmation!)
      user.save!
      
      # Create avatar for user if it doesn't exist
      if user.avatar.blank?
        user.avatar = Avatar.new
        user.save!
      end
      
      users << user
      puts "Created user: #{name} (#{email})"
    end
    
    users
  end
  
  def create_investor_users(count)
    puts "Creating #{count} investor users..."
    users = []
    
    count.times do |i|
      name = "investor_#{i+1}"
      email = "investor_#{i+1}@example.com"
      
      user = User.where(email: email).first_or_create(
        name: name,
        password: "password123",
        password_confirmation: "password123",
        description: "这是一个投资人账号，用于展示投资相关功能。"
      )
      
      # Skip confirmation to make the account usable immediately
      user.skip_confirmation! if user.respond_to?(:skip_confirmation!)
      user.save!
      
      # Create avatar for user if it doesn't exist
      if user.avatar.blank?
        user.avatar = Avatar.new
        user.save!
      end
      
      users << user
      puts "Created investor user: #{name} (#{email})"
    end
    
    users
  end
  
  def create_projects(users, count)
    puts "Creating #{count} projects..."
    projects = []
    
    categories = Category.all.to_a
    cities = City.all.to_a
    project_stages = Project::STAGES
    
    count.times do |i|
      owner = users[i % users.length]
      
      project = Project.where(name: "项目_#{i+1}").first_or_create(
        oneword: "这是项目#{i+1}的一句话描述",
        description: "这是项目#{i+1}的详细描述。本项目旨在解决用户在日常生活中遇到的问题，提供创新的解决方案，创造商业价值。",
        stage: project_stages[i % project_stages.length],
        published: true
      )
      
      # Add owner to project
      unless project.owner
        project.add_owner(owner)
      end
      
      # Add categories (1-3 random categories)
      selected_categories = categories.sample(rand(1..3))
      selected_categories.each do |category|
        project.categories << category unless project.categories.include?(category)
      end
      
      # Add cities (1-2 random cities)
      selected_cities = cities.sample(rand(1..2))
      selected_cities.each do |city|
        project.cities << city unless project.cities.include?(city)
      end
      
      project.save!
      projects << project
      puts "Created project: #{project.name} (owner: #{owner.name})"
    end
    
    projects
  end
  
  def add_team_members_to_projects(projects, users)
    puts "Adding team members to projects..."
    
    projects.each do |project|
      # Add 1-3 random users as team members (excluding the owner)
      potential_members = users.reject { |u| u == project.owner }
      team_size = [potential_members.size, 3].min
      selected_members = potential_members.sample(rand(1..team_size))
      
      selected_members.each do |user|
        # Skip if the user is already a member
        next if project.member(user).present?
        
        # Assign random role (except FOUNDER which is for owner)
        roles = Member::ROLES.reject { |r| r == :FOUNDER }
        role = roles.sample
        
        # Assign random privilege (except owner)
        privs = Member::PRIVS.reject { |p| p == "owner" }
        priv = privs.sample
        
        project._add_user(user, role: role, priv: priv)
        puts "Added #{user.name} to project #{project.name} as #{role} with #{priv} privileges"
      end
      
      project.save!
    end
  end
  
  def create_money_requires(projects)
    puts "Creating money requires for projects..."
    money_requires = []
    
    projects.each_with_index do |project, i|
      # Create only for some projects (not all)
      next if i % 3 == 0 # Skip every third project
      
      # Check if project already has an open money_require
      next if project.money_requires.where.not(status: :closed).exists?
      
      money = [500000, 1000000, 2000000, 5000000, 10000000].sample
      share = rand(5..30)
      deadline = [30, 60, 90, 120].sample
      maxnp = rand(MoneyRequire::NP_MIN..MoneyRequire::NP_MAX)
      
      money_require = MoneyRequire.create!(
        project_id: project.id,
        money: money,
        share: share,
        deadline: deadline,
        maxnp: maxnp,
        description: "#{project.name}的融资需求，计划融资#{money/10000}万元，占股#{share}%，融资期限#{deadline}天。"
      )
      
      # For some money_requires, set them to opened status with a leader
      if i % 2 == 0
        # Find a random user with investor role if any exists
        leader = User.with_role(:investor).sample || User.first
        
        # Quickly turn on the money_require for demo purposes
        money_require.quickly_turn_on!(leader.id)
        puts "Created and opened money require for project: #{project.name} with leader: #{leader.name}"
      else
        puts "Created money require for project: #{project.name} (status: #{money_require.status})"
      end
      
      money_requires << money_require
    end
    
    money_requires
  end
  
  def create_person_requires(projects)
    puts "Creating person requires for projects..."
    
    projects.each_with_index do |project, i|
      # Create 0-2 person_requires per project
      rand(0..2).times do |j|
        titles = ["技术总监", "市场经理", "产品经理", "UI设计师", "前端开发", "后端开发", "运营总监"]
        title = titles.sample
        
        pay = rand(10000..50000)
        stock = rand(0..5)
        option = rand(0..5)
        
        person_require = PersonRequire.create!(
          project_id: project.id,
          title: title,
          pay: pay,
          stock: stock,
          option: option,
          description: "#{project.name}正在招聘#{title}，月薪#{pay}元，期权#{option}%，股份#{stock}%。要求有相关领域3年以上工作经验，熟悉行业发展，有良好的沟通能力和团队协作精神。",
          status: ["opened", "closed"].sample
        )
        
        puts "Created person require: #{title} for project: #{project.name} (status: #{person_require.status})"
      end
    end
  end
  
  def create_investors_and_investments(users, money_requires)
    puts "Creating investors and investments..."
    
    users.each_with_index do |user, i|
      # Create investor profile for each investor user
      investor = Investor.where(user_id: user.id).first_or_create do |investor|
        investor.investor_type = Investor::INVESTOR_TYPES.sample
        investor.company = ["投资基金有限公司", "创投资本", "天使投资人联盟", "风险投资集团"].sample
        investor.title = ["投资经理", "合伙人", "投资总监", "CEO"].sample
        investor.phone = "1381234#{format('%04d', i+1)}"
        investor.status = 'passed'
      end
      
      # Add investor role to user if they don't have it
      user.add_role(:investor) unless user.has_role?(:investor)
      
      # Create investidea (investment preferences)
      if investor.investidea.nil?
        industry = ["科技", "金融", "医疗健康", "教育科技"].sample
        give = ["早期项目", "成长期项目"].sample
        coin_type = Investidea::COIN_TYPES.sample
        min = rand(100000..500000)
        max = min + rand(100000..1000000)
        Investidea.create!(
          investor_id: investor.id,
          industry: industry,
          give: give,
          coin_type: coin_type,
          min: min,
          max: max,
          idea: "关注#{['电子商务', '人工智能', '医疗健康', '教育科技'].sample}等领域的早期项目投资，投资金额通常在100万到500万之间。"
        )
      end
      
      puts "Created investor profile for: #{user.name} (#{investor.investor_type}, #{investor.company})"
      
      # Create 1-3 investments for opened money_requires
      opened_money_requires = money_requires.select(&:opened?)
      
      # Skip if no opened money requires
      next if opened_money_requires.empty?
      
      # Select 1-3 random money_requires to invest in
      selected_requires = opened_money_requires.sample(rand(1..[3, opened_money_requires.size].min))
      
      selected_requires.each do |money_require|
        # Skip if already invested
        next if money_require.has_invested?(user)
        
        # Calculate investment amount (between min_money and 30% of total)
        min_amount = money_require.min_money
        max_amount = (money_require.money * 0.3).to_i
        amount = rand(min_amount..max_amount)
        
        investment = Investment.create!(
          money_require_id: money_require.id,
          user_id: user.id,
          money: amount,
          status: "unconfirmed"
        )
        
        puts "Created investment of #{amount} for money_require: #{money_require.id} by investor: #{user.name}"
      end
    end
  end
  
  def create_stars(users, projects)
    puts "Creating project stars (followers)..."
    
    users.each do |user|
      # Each user follows 2-5 random projects
      starred_projects = projects.sample(rand(2..5))
      
      starred_projects.each do |project|
        # Skip if already starred
        next if user.star?(project)
        
        user.add_star(project)
        puts "User #{user.name} is now following project: #{project.name}"
      end
    end
  end
end