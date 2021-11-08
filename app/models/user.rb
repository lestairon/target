class User < ApplicationRecord
  devise :registerable, :database_authenticatable
  include DeviseTokenAuth::Concerns::User

  validates :email, presence: true, uniqueness: true
end
