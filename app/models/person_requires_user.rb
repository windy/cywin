class PersonRequiresUser < ActiveRecord::Base

  belongs_to :user
  belongs_to :person_require

end
