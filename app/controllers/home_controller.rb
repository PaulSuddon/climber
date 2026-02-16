class HomeController < ApplicationController
  def index
    @featured_trips = Trip.available.includes(:destination, :user).limit(6)
    @climbing_count = Destination.climbing_spots.count
    @hiking_count = Destination.hiking_spots.count
  end
end
