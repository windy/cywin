class Project < ActiveRecord::Base
  validates :name, presence: true, :uniqueness => true, :length => { :minimum => 4 }
  validates :oneword, presence: true, :length => { :minimum => 4 }
  validates :stage, presence: true
  validates :where1, presence: true
  validates :where2, presence: true

  validates :logo, presence: true

  mount_uploader :logo, LogoUploader
end
