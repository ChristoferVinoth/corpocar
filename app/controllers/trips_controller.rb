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
    @trips = Trip.includes(:driver).all
  end

  def show
    @trip = Trip.includes(:requests).joins(:driver).find(params[:id])
  end

  def destroy
    @trip = Trip.find(params[:id])
    @requests = Request.where(trip_id: @trip.id)
    @requests.each do |request|
      request.destroy
    end
    @trip.destroy
    redirect_to root_path
  end
end
