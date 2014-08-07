class InviteCode < ActiveRecord::Base
  validates :code, presence: true

  scope :default_order, -> { order(created_at: :desc) }


  # 生成 n 个邀请码
  def self.generate(n)
    if n < 1
      return false
    end

    count = InviteCode.count
    if count + n > 2000
      # 最多支持 2000 个邀请码
      return false
    end

    all = InviteCode.all.collect { |m| m.code }

    ((0..999999).to_a - all).sample(n).each do |code|
      self.create(code: code)
    end
    return true
  end

  def self.validate_code(code)
    !! InviteCode.where(used: false).where(code: code).first
  end

  def self.mark_used(code)
    InviteCode.where(code: code).update_all(used: true)
  end
end
