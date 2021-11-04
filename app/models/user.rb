class User < ApplicationRecord
  devise :registerable, :database_authenticatable, :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
end
