class Contact < ActiveRecord::Base
  validates :address, :phone, presence: true
  belongs_to :project
end
