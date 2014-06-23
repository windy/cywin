class Card < ActiveRecord::Base
  belongs_to :investor
  mount_uploader :image, CardUploader
end
