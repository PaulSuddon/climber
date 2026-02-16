class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @trips_as_driver = @user.trips.order(departure_date: :desc).limit(5)
    @recent_bookings = @user.bookings.confirmed.joins(:trip).order("trips.departure_date DESC").limit(5)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      redirect_to profile_path(@user), notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :bio, :avatar)
  end
end

