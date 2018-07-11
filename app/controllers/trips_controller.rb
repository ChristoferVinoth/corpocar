class TripsController < ApplicationController

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(params[:trip])
    @trip.save
    redirect_to trips_path
  end

  def index
    @trips = Trip.all 
  end
end
