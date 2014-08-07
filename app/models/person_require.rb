class PersonRequire < ActiveRecord::Base

  searchable do
    text :title, :description
    string :status
  end

  PER_PAGE = 10
  paginates_per PER_PAGE

  belongs_to :project

  has_and_belongs_to_many :users
  has_many :person_requires_users
  
  validates :title, presence: true
  validates :description, presence: true
  validates :pay, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 100, only_integer: true }
  validates :option, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 100, only_integer: true }
  
  scope :default_order, -> { order(created_at: :desc) }
  scope :opened, -> { where(status: 'opened') }

  def opened?
    self.status.blank? or self.status == 'opened'
  end

  def open
    self.status = 'opened'
    self.save!
  end

  def closed?
    self.status == 'closed'
  end

  def close
    self.status = 'closed'
    self.save!
  end

end
