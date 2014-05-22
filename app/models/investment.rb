class Investment < ActiveRecord::Base
  belongs_to :user
  belongs_to :money_require

  #validates_associated :user

  # 只有一份投资
  validates :money_require_id, uniqueness: { scope: :user_id, message: '不能重复投资' }

  validates :money, presence: true, numericality: { greater_than: 0, only_integer: true }, if: Proc.new { |m| m.money_require_id.present? }

  validate do |m|
    if m.money_require_id.present?
      min_money = m.money_require.min_money
      errors.add(:money, "不能低于最低投资额限制: #{min_money} 元") if m.money < min_money
    end
  end

  validate do |m|
    if m.money_require_id.present? && m.money_require.status != 'opened'
      errors.add(:base, "无法投资非 opened 状态的融资需求")
    end
  end

  after_save do |m|
    if m.money_require_id.present?
      if m.money_require.progress >= 1
        m.money_require.close!
      end
    end
  end
 
end
