class TripsController < ApplicationController

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(params[:trip])
    @trip.driver_id = current_user.id
    @trip.save
    redirect_to controller: 'requests', action: 'create_driver_request' , id:@trip.id
    #redirect_to trip_path(@trip)
  end

  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
  end
end
