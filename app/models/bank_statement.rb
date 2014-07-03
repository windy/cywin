class BankStatement < ActiveRecord::Base
  belongs_to :investor
  mount_uploader :image, BankStatementUploader
end
