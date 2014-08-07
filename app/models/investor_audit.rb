class InvestorAudit < ActiveRecord::Base

  my_const_set(:AUDITS, [:PASSED, :REJECTED, :APPLIED])
  
  validates :investor_id, presence: true
  validates :status, presence: true, inclusion: AUDITS

  belongs_to :investor

  scope :default_order, -> { order(created_at: :desc) }

end
