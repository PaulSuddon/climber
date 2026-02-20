class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def stats
    @user_count = User.count
    @trip_count = Trip.count
    @booking_count = Booking.count
    @destination_count = Destination.count
    @rating_count = Rating.count

    @recent_users = User.order(created_at: :desc).limit(10)
    @recent_trips = Trip.includes(:user).order(created_at: :desc).limit(10)
    @recent_bookings = Booking.includes(:user, :trip).order(created_at: :desc).limit(10)
  end

  private

  def authorize_admin!
    unless current_user.email == "paulsuddon@gmail.com"
      redirect_to root_path, alert: "Not authorized."
    end
  end
end
