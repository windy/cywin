class InvestorAudits < ActiveRecord::Base
  AUDIT = []
  [
    :PASSED,
    :REJECTED,
  ].each do |e|
    real_name = e.to_s.underscore
    AUDIT << real_name
    const_set(e, real_name)
  end
  
  validates :investor_id, presence: true
  validates :status, presence: true, inclusion: AUDIT
end
