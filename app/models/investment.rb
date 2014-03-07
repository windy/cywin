class Investment < ActiveRecord::Base
  belongs_to :investor
  belongs_to :money_require

  # 只有一份投资
  validates :money_require_id, uniqueness: { scope: :investor_id }

  validate do |m|
    if m.money_require_id.present? && m.money_require.status != 'open'
      errors.add(:base, "无法投资非 open 状态的融资需求")
    end
  end
 
  validates :money, presence: true, numericality: { greater_than: 0, only_integer: true }, if: Proc.new { |m| m.money_require_id.present? }
end
