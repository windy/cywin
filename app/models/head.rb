class Head < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  has_many :categories
end
