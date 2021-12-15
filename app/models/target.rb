class Target < ApplicationRecord
  belongs_to :topic
  belongs_to :user, counter_cache: true
  reverse_geocoded_by :latitude, :longitude

  validates :title, presence: true
  validates :longitude, numericality: { greater_than: -180, less_than: 180 }
  validates :latitude, numericality: { greater_than: -90, less_than: 90 }
  validates :radius, numericality: { only_integer: true }
  validate :number_of_user_targets
  after_validation :reverse_geocode
  delegate :name, to: :topic, prefix: true

  private

  def number_of_user_targets
    errors.add(:user, 'exceeded number of targets limit') if user&.can_add_more_targets?
  end
end
