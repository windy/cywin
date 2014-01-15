class AddExtraToUsers < ActiveRecord::Migration
  def change
    add_column :users, :qq, :string
    add_column :users, :douban, :string
    add_column :users, :renren, :string
    add_column :users, :sinaweibo, :string
    add_column :users, :avatar, :binary #头像照片

    add_column :users, :invest_count, :integer #投资项目数
    add_column :users, :invest_total, :decimal #投资总额
    add_column :users, :prestig, :integer #威望
    add_column :users, :honour, :integer #勋章

    add_column :users, :introduction, :text #个人简介
    add_column :users, :work_experience, :text #工作经历
    add_column :users, :education_experience, :text #教育经历

    ## 投资理念
    add_column :users, :found_type, :string #资金类型 1.人民币 2.外币 3.人民币+外币
    add_column :users, :min_invest, :decimal #最小投资金额
    add_column :users, :max_invest, :decimal #最大投资金额

    # 以下为选填项
    add_column :users, :focus_industry, :text #关注的行业(以tag标签的形式存储在数据库中)
    add_column :users, :investment_philosophy, :text #投资理念(以tag标签的形式存储在数据库中)
    add_column :users, :added_value, :text #能为项目提供的附加价值(以tag标签的形式存储在数据库中)
  end
end
