def check_json(json_str, key, expected)
  unless json_str.kind_of?(JSON)
    json_str = JSON.parse(json_str)
  end
  
  result = json_str[key.to_sym] || json_str[key.to_s]
  expect(result).to be(expected)
end

def create_project_with_owner(owner = nil)
  owner ||= @user
  owner ||= create(:user)
  project = build(:project)
  project.add_owner!(owner)
  project
end

def create_investor_user(user_sym = :user, norole:  false, investor: :investor)
  if ! user_sym.kind_of?(User)
    user = create(user_sym)
  else
    user = user_sym
  end
  user.investor = build(investor)
  unless norole
    user.add_role(:investor)
  end
  user.save!
  user
end
