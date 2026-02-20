class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_trips = current_user.trips.includes(:destination, :bookings).order(departure_date: :desc)
    @my_bookings = current_user.bookings.includes(trip: [:destination, :user]).where.not(status: [:cancelled, :rejected]).order(created_at: :desc)
    @pending_requests = Booking.pending.joins(:trip).where(trips: { user_id: current_user.id }).includes(:user, trip: :destination).order(created_at: :desc)

    # Find completed trips where user can rate someone
    # As passenger: rate the driver
    @trips_to_rate_as_passenger = current_user.bookings.confirmed
      .joins(:trip)
      .where(trips: { status: :completed })
      .includes(trip: :user)
      .reject { |b| Rating.exists?(trip: b.trip, reviewer: current_user, rated_user: b.trip.user) }

    # As driver: rate passengers
    @passengers_to_rate = Booking.confirmed
      .joins(:trip)
      .where(trips: { user_id: current_user.id, status: :completed })
      .includes(:user, :trip)
      .reject { |b| Rating.exists?(trip: b.trip, reviewer: current_user, rated_user: b.user) }
  end
end
