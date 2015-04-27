@app.config ['$translateProvider', ($translateProvider)->
  $translateProvider.translations 'en',
    # Project Create Page
    'basic': 'Basic Info',
    'team': 'Team Info',
    'invest': 'Invest Plan',
    'next': 'Next',
    'confirm': 'Confirm',
    'cancel': 'Cancel',
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

  $translateProvider.translations 'zh-CN',
    'basic': '基本信息'
    'team': '团队信息'
    'invest': '融资计划'
    'next': '下一步'
    'confirm': '确认',
    'cancel': '取消',
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

  $translateProvider.preferredLanguage('en')
]

