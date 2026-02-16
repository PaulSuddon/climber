class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip

  def create
    @booking = @trip.bookings.build(booking_params)
    @booking.user = current_user
    @booking.status = :confirmed

    if @booking.save
      update_trip_status
      redirect_to @trip, notice: "Booking confirmed! You have booked #{@booking.seats_booked} seat(s)."
    else
      redirect_to @trip, alert: @booking.errors.full_messages.join(", ")
    end
  end

  def destroy
    @booking = @trip.bookings.find(params[:id])

    if @booking.user == current_user
      @booking.update(status: :cancelled)
      redirect_to dashboard_path, notice: "Booking cancelled successfully."
    else
      redirect_to @trip, alert: "You are not authorized to cancel this booking."
    end
  end

  private

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def booking_params
    params.require(:booking).permit(:seats_booked)
  end

  def update_trip_status
    if @trip.seats_remaining == 0
      @trip.update(status: :full)
    end
  end
end
