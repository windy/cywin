class Screenshot < ActiveRecord::Base
  belongs_to :project
  mount_uploader :image, ScreenshotUploader
end
