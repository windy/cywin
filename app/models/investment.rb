class Investment < ActiveRecord::Base
  belongs_to :user
  belongs_to :money_require

  validates_associated :user

  # 只有一份投资
  validates :money_require_id, uniqueness: { scope: :user_id, message: '不能重复投资' }

  validate do |m|
    if m.money_require_id.present? && m.money_require.status != 'opened'
      errors.add(:base, "无法投资非 opened 状态的融资需求")
    end
  end
 
  validates :money, presence: true, numericality: { greater_than: 0, only_integer: true }, if: Proc.new { |m| m.money_require_id.present? }
end
