class Target < ApplicationRecord
  belongs_to :topic
  belongs_to :user

  validates :title, presence: true
  validates :longitude, numericality: { greater_than: -180, less_than: 180 }
  validates :latitude, numericality: { greater_than: -90, less_than: 90 }
  validates :radius, numericality: { only_integer: true }
end
