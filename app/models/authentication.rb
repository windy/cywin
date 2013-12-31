class Authentication < ActiveRecord::Base
  #attr_accessor :user_id, :provider, :uid, :access_token
  belongs_to :user

  validates :provider, :uid, :access_token, presence: true
  validates :provider, uniqueness: { scope: :user_id }

  def self.create_from_hash(user_id, omniauth)
    self.create!(user_id: user_id,
                 provider: omniauth.provider,
                 uid: omniauth.uid,
                 access_token: omniauth.credentials.token
    )
  end
end
