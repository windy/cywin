class Logo < ActiveRecord::Base
  belongs_to :project
  mount_uploader :image, LogoUploader
end
