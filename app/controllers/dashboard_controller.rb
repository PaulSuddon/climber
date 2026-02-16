class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_trips = current_user.trips.includes(:destination, :bookings).order(departure_date: :desc)
    @my_bookings = current_user.bookings.includes(trip: [:destination, :user]).where.not(status: :cancelled).order(created_at: :desc)
  end
end
