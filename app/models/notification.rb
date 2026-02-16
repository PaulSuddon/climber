class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read: false) }
  scope :recent, -> { order(created_at: :desc) }

  TYPES = %w[booking_created booking_confirmed booking_rejected trip_cancelled].freeze

  validates :notification_type, inclusion: { in: TYPES }

  def mark_as_read!
    update!(read: true)
  end
end
