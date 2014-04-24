class PersonRequire < ActiveRecord::Base
  belongs_to :project
  
  validates :title, presence: true
  validates :description, presence: true
  validates :pay, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :stock, presence: true, numericality: { greater_than: 0, less_than: 100, only_integer: true }
  validates :option, presence: true, numericality: { greater_than: 0, less_than: 100, only_integer: true }
end
