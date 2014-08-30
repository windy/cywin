class Investor < ActiveRecord::Base
  paginates_per 10

  searchable if: proc { |investor| investor.applied? } do
    text :name do
      user.name
    end

    text :description do
      user.description
    end
    string :investor_type
    string :status
  end

  my_const_set(:INVESTOR_TYPES, [ :PERSON, :ORGANIZATION ])

  # status 标志是否开始审核, 并同时创建审核单
  state_machine :status, initial: :drafted do
    event :submit do
      transition [:drafted, :rejected] => :applied
    end

    after_transition on: :submit do |investor, transition|
      #Event.create(
        #user: investor.user,
        #action: Event::APPLY_INVESTOR,
        #target: investor,
      #)
    end
    
    event :reject do
      transition :applied => :rejected
    end

    after_transition on: :reject do |investor, transition|
      #Event.create(
        #user: investor.user,
        #action: Event::APPLY_INVESTOR_FAIL,
        #target: investor,
      #)
      investor.user.remove_role(:investor)
      Message.create(
        user_id: investor.user.id,
        action: Message::APPLY_INVESTOR_FAIL,
        must_action: false,
        target: investor,
      )
    end

    event :pass do
      transition :applied => :passed
    end

    after_transition on: :pass do |investor, transition|
      Event.create(
        user: investor.user,
        action: Event::APPLY_INVESTOR_SUCCESS,
        target: investor,
      )
      investor.user.add_role(:investor)
      Message.create(
        user_id: investor.user.id,
        action: Message::APPLY_INVESTOR_SUCCESS,
        must_action: false,
        target: investor,
      )
    end
  end

  belongs_to :user
  has_one :investidea
  has_many :investor_audits

  # 领投人信息
  has_many :money_require, through: :leader_id

  validates :user_id, presence: true

  # basic info validates

  validates :phone, presence: true
  validates :investor_type, presence: true, inclusion: INVESTOR_TYPES
  validates :company, presence: true
  validates :title, presence: true

  scope :default_order, -> { order(created_at: :desc) }
  scope :passed, -> { where(status: 'passed') }

  has_one :card
  has_one :bank_statement

  def description
    self.user.description
  end

  def submit_with_audit(note = nil)
    investor_audit = InvestorAudit.new
    investor_audit.note = note
    investor_audit.status = InvestorAudit::APPLIED
    investor_audit.investor = self
    investor_audit.save!
    self.submit!
  end

  def pass_with_audit(note = nil)
    investor_audit = InvestorAudit.new
    investor_audit.note = note
    investor_audit.status = InvestorAudit::PASSED
    investor_audit.investor = self
    investor_audit.save!
    self.pass!
  end

  def reject_with_audit(note = nil)
    investor_audit = InvestorAudit.new
    investor_audit.note = note
    investor_audit.status = InvestorAudit::REJECTED
    investor_audit.investor = self
    investor_audit.save!
    self.reject!
  end
end
