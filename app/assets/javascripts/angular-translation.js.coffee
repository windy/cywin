@app.config ['$translateProvider', ($translateProvider)->
  $translateProvider.translations 'en',
    # Project Create Page
    'basic': 'Basic Info',
    'team': 'Team Info',
    'invest': 'Invest Plan',
    'next': 'Next',
    'confirm': 'Confirm',
    'cancel': 'Cancel',
    'edit': 'Edit',
    'add' : 'Add',
    'back' : 'Back',
    'remove': 'Remove',
    'true': 'Yes',
    'false': 'No',
    'complete': 'Complete'
    'project_info': 'Project Info'
    'project_name': 'Project Name'
    'project_name_placeholder': 'e.g. Google'
    'project_logo': 'Logo( 200x200 please )'
    'project_screenshot': 'Screenshot'
    'project_oneword': 'One Word'
    'project_oneword_placeholder': 'one word please, will be as subtitle'
    'project_link': 'Link( optional )'
    'project_link_placeholder': 'project link here'
    'project_description': 'Description'
    'project_description_placeholder': 'describe your whole project info'
    'project_industry': 'Choose Industries'
    'project_industry_select': 'Click to select'
    'project_industry_tip': 'Your selection will be showed here'
    'project_city': 'City'
    'project_city_placeholder': 'Input the complete city name'
    # select industries
    'select_industry_title': 'What industry(s) your project belongs to'
    'select_industry_no_content': 'No selected'
    'select_industry_header': 'Header'
    'select_industry_subheader': 'Sub Header'
    # project create team
    'project_team_owner_title': 'Edit Founder Info'
    'project_team_owner_name_label': 'Real Full Name'
    'project_team_owner_name_placeholder': 'Full Name'
    'project_team_owner_title_label': 'Title'
    'project_team_owner_title_placeholder': 'Your title at team'
    'project_team_owner_description_label': 'Detail Info'
    'project_team_our_story': 'Our Team Story'
    'project_team_our_story_placeholder': 'Our Team Story Here'
    'project_team_member': 'Our Team Members'
    'project_team_member_edit_title': 'Edit Member Info'
    'project_team_member_edit_title_placeholder': 'Title'
    'project_team_member_edit_title_description': 'Detail Info'
    'project_team_member_joined': 'Joined'
    'project_team_member_unconfirmed': 'Email unconfirmed'
    'project_team_member_invite_label': 'Invite new member'
    'project_team_member_invite_placeholder': 'Username or Email'
    'project_team_member_invite_tip': 'This member has not register account, we will send an email to him(her).'
    'project_team_member_invite_name': 'Real Full Name'
    'project_team_member_invite_button': 'Send'
    'project_team_member_add_button': 'Add New Member'
    # Project create invest
    'project_invest_purpose': 'What purpose when you come here'
    'project_invest_title': 'I am looking for investments'
    'project_invest_money': 'How much fund for investment'
    'project_invest_stock': 'How much stock for investment'
    'project_invest_job_title': 'I am looking for talented wokers'
    'project_invest_job_title_name': 'Position'
    'project_invest_job_description': 'Description'
    'project_invest_job_pay': 'Salary'
    'project_invest_job_option': 'Option'
    'project_invest_job_stock': 'Stock'
    'project_invest_job_remote': 'Remote-work'
    'project_invest_job_part': 'Part-time'
    'project_invest_job_new': 'New Job'

  $translateProvider.translations 'zh-CN',
    'basic': '基本信息'
    'team': '团队信息'
    'invest': '融资计划'
    'next': '下一步'
    'confirm': '确认',
    'cancel': '取消',
    'edit': '编辑',
    'add' : '添加',
    'remove': '移除',
    'back' : '返回上一步',
    'true': '是',
    'false': '否',
    'complete': '确认完成'
    'project_info': '项目信息'
    'project_name': '项目名称'
    'project_name_placeholder': '如: 百度'
    'project_logo': 'Logo( 建议使用 200x200 尺寸大小 )'
    'project_screenshot': '产品截图'
    'project_oneword': '一句话'
    'project_oneword_placeholder': '一句话说明, 将显示在项目副标题'
    'project_link': '链接( 可选 )'
    'project_link_placeholder': '项目链接'
    'project_description': '产品介绍'
    'project_description_placeholder': '完整描述你的产品'
    'project_industry': '所属行业'
    'project_industry_select': '点击选择'
    'project_industry_tip': '选择的行业将会显示在这里'
    'project_city': '城市'
    'project_city_placeholder': '请用中文输入, 如深圳'
    'select_industry_title': '选择一个或多个行业'
    'select_industry_no_content': '选择的行业将会显示在这里'
    'select_industry_header': '一级分类'
    'select_industry_subheader': '二级分类'
    # project create team
    'project_team_owner_title': '编辑个人信息'
    'project_team_owner_name_label': '真实姓名'
    'project_team_owner_name_placeholder': '真实姓名'
    'project_team_owner_title_label': '职位'
    'project_team_owner_title_placeholder': '你在团队的职位'
    'project_team_owner_description_label': '更多详细信息'
    'project_team_our_story': '我们的团队故事'
    'project_team_our_story_placeholder': '我们的团队故事'
    'project_team_member': '我们的成员'
    'project_team_member_edit_title': '编辑成员信息'
    'project_team_member_edit_title_placeholder': '职位'
    'project_team_member_edit_title_description': '详细描述'
    'project_team_member_joined': '已加入'
    'project_team_member_unconfirmed': '邮件未确认'
    'project_team_member_invite_label': '邀请新成员'
    'project_team_member_invite_placeholder': '用户名或者邮箱'
    'project_team_member_invite_tip': '这个用户尚未注册, 你可以邀请加入团队, 我们会自动发送邀请邮件, 一旦注册, 将自动加入团队'
    'project_team_member_invite_name': '真实姓名'
    'project_team_member_invite_button': '发送'
    'project_team_member_add_button': '添加新的成员'
    # Project create invest
    'project_invest_purpose': '在这里的目的'
    'project_invest_title': '我要融资'
    'project_invest_money': '计划融资'
    'project_invest_stock': '出让股份'
    'project_invest_job_title': '我要招人'
    'project_invest_job_title_name': '职位'
    'project_invest_job_description': '负责内容'
    'project_invest_job_pay': '报酬'
    'project_invest_job_option': '期权'
    'project_invest_job_stock': '股权'
    'project_invest_job_remote': '远程办公'
    'project_invest_job_part': '可兼职'
    'project_invest_job_new': '添加新的招聘'

  $translateProvider.preferredLanguage('zh-CN')
]
