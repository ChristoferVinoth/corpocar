class TripsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(params[:trip])
    @trip.driver_id = current_user.id
    @trip.save
    @request = Request.new
    @request.rider_id = current_user.id
    @request.trip_id = @trip.id
    @request.confirmed = true
    if @request.save
      @requests = Request.where(rider_id: @request.rider_id, confirmed: false )
      @requests.each do |r|
        r.destroy
      end
    end
    redirect_to trip_path(@trip)
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update_attributes(params[:trip])
    redirect_to trip_path(@trip)
  end

  def index
    @trips = Trip.includes(:driver).all
  end

  def show
    @trip = Trip.includes(:requests).joins(:driver).find(params[:id])
  end

  def destroy
    @trip = Trip.find(params[:id])
    MailWorker.perform_async('cancel', @trip.id)
    redirect_to root_path
  end

  def seat_change
    @trip = Trip.find(params[:id])
    if params[:mode] == 'inc'
      @trip.update_attribute(:available_seats, @trip.available_seats+1)
    else
      @trip.update_attribute(:available_seats, @trip.available_seats-1) if @trip.available_seats > 0
    end
    render partial: 'trips/requesters'
  end
end
