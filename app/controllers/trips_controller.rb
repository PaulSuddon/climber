class TripsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @trips = Trip.available.includes(:destination, :user)

    if params[:activity_type].present?
      @trips = @trips.where(activity_type: params[:activity_type])
    end

    if params[:destination].present?
      @trips = @trips.where("destination_name ILIKE ?", "%#{params[:destination]}%")
    end

    if params[:date].present?
      date = Date.parse(params[:date])
      @trips = @trips.where(departure_date: date.beginning_of_day..date.end_of_day)
    end

    if params[:join_activity].present?
      @trips = @trips.where(join_activity: params[:join_activity] == "true")
    end
  end

  def show
    @booking = Booking.new
  end

  def new
    @trip = current_user.trips.build
  end

  def create
    @trip = current_user.trips.build(trip_params)

    if @trip.save
      redirect_to @trip, notice: "Trip was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @trip.update(trip_params)
      redirect_to @trip, notice: "Trip was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @trip.destroy
    redirect_to dashboard_path, notice: "Trip was successfully cancelled."
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def authorize_user!
    unless @trip.user == current_user
      redirect_to trips_path, alert: "You are not authorized to perform this action."
    end
  end

  def trip_params
    params.require(:trip).permit(:destination_name, :destination_address, :activity_type,
                                  :departure_date, :departure_location,
                                  :available_seats, :price_per_seat, :description, :status, :join_activity)
  end
end
