class Destination < ApplicationRecord
  enum :activity_type, { climbing: 0, hiking: 1 }

  has_many :trips, dependent: :destroy

  validates :name, presence: true
  validates :activity_type, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  scope :climbing_spots, -> { where(activity_type: :climbing) }
  scope :hiking_spots, -> { where(activity_type: :hiking) }
end
