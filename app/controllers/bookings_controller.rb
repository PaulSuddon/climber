class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip
  before_action :set_booking, only: [:destroy, :confirm, :reject]

  def create
    @booking = @trip.bookings.build(booking_params)
    @booking.user = current_user
    @booking.status = :pending

    if @booking.save
      redirect_to @trip, notice: "Booking request sent! The driver will confirm your booking."
    else
      redirect_to @trip, alert: @booking.errors.full_messages.join(", ")
    end
  end

  def confirm
    if @trip.user == current_user
      @booking.confirm!
      update_trip_status
      redirect_to dashboard_path, notice: "Booking confirmed successfully."
    else
      redirect_to @trip, alert: "You are not authorized to confirm this booking."
    end
  end

  def reject
    if @trip.user == current_user
      @booking.reject!
      redirect_to dashboard_path, notice: "Booking rejected."
    else
      redirect_to @trip, alert: "You are not authorized to reject this booking."
    end
  end

  def destroy
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

  def set_booking
    @booking = @trip.bookings.find(params[:id])
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
