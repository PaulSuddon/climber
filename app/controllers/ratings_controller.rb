class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip
  before_action :set_rated_user, only: [:new, :create]

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(rating_params)
    @rating.trip = @trip
    @rating.reviewer = current_user
    @rating.rated_user = @rated_user

    if @rating.save
      redirect_to @trip, notice: "Rating submitted successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_rated_user
    @rated_user = User.find(params[:user_id])
  end

  def rating_params
    params.require(:rating).permit(:rating, :comment)
  end
end
