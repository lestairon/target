class Target < ApplicationRecord
  belongs_to :topic
  belongs_to :user

  validates :longitude, :latitude, :radius, :title, presence: true
end
