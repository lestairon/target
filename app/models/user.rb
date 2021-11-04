class User < ApplicationRecord
  devise :registerable, :database_authenticatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  validates :email, presence: true, uniqueness: { scope: :provider }
end
