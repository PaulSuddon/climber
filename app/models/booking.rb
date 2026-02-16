class Booking < ApplicationRecord
  belongs_to :trip
  belongs_to :user

  enum :status, { pending: 0, confirmed: 1, cancelled: 2 }

  validates :seats_booked, presence: true, numericality: { greater_than: 0 }
  validate :cannot_book_own_trip
  validate :seats_available, on: :create

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
end
