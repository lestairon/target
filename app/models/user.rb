class User < ApplicationRecord
  devise :registerable, :database_authenticatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  has_many :targets, dependent: :destroy
  validates :email, presence: true, uniqueness: { scope: :provider }
end
