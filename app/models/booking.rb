class Booking < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  has_many :notifications, as: :notifiable, dependent: :destroy

  enum :status, { pending: 0, confirmed: 1, cancelled: 2, rejected: 3 }

  validates :seats_booked, presence: true, numericality: { greater_than: 0 }
  validate :cannot_book_own_trip
  validate :seats_available, on: :create

  after_create :notify_driver

  def confirm!
    update!(status: :confirmed)
    Notification.create!(
      user: user,
      notifiable: self,
      notification_type: "booking_confirmed",
      message: "Your booking for #{trip.display_name} has been confirmed!"
    )
  end

  def reject!
    update!(status: :rejected)
    Notification.create!(
      user: user,
      notifiable: self,
      notification_type: "booking_rejected",
      message: "Your booking for #{trip.display_name} has been rejected."
    )
  end

  private

  def cannot_book_own_trip
    if trip && user == trip.user
      errors.add(:base, "You cannot book your own trip")
    end
  end

  def seats_available
    return unless trip && seats_booked

    if seats_booked > trip.seats_remaining
      errors.add(:seats_booked, "exceeds available seats")
    end
  end

  def notify_driver
    Notification.create!(
      user: trip.user,
      notifiable: self,
      notification_type: "booking_created",
      message: "#{user.name} has requested to join your trip to #{trip.display_name}"
    )
  end
end
