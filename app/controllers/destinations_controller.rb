class DestinationsController < ApplicationController
  def index
    @destinations = Destination.all.order(:name)

    if params[:activity_type].present?
      @destinations = @destinations.where(activity_type: params[:activity_type])
    end
  end

  def show
    @destination = Destination.find(params[:id])
    @upcoming_trips = @destination.trips.available.includes(:user).limit(5)
  end
end
