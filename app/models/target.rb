class Target < ApplicationRecord
  belongs_to :topic
  belongs_to :user, counter_cache: true

  MAX_ALLOWED_TARGETS = 10

  validates :title, presence: true
  validates :longitude, numericality: { greater_than: -180, less_than: 180 }
  validates :latitude, numericality: { greater_than: -90, less_than: 90 }
  validates :radius, numericality: { only_integer: true }
  before_save :validate_number_of_user_targets

  private

  def validate_number_of_user_targets
    raise RangeError, 'Exceeded number of targets limit' if hit_target_limit?
  end

  def hit_target_limit?
    user.reload.targets.size >= MAX_ALLOWED_TARGETS
  end
end
