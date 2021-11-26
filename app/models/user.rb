class User < ApplicationRecord
  devise :registerable, :database_authenticatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  MAX_ALLOWED_TARGETS = 10

  has_many :targets, dependent: :destroy
  validates :email, presence: true, uniqueness: { scope: :provider }

  def can_add_more_targets?
    targets.count >= MAX_ALLOWED_TARGETS
  end
end
