class TripsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_trip, only:[:edit,:update,:destroy,:seat_change,:finish]

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.set_trip_values(params[:trip],current_user.id)
    request_hash = {"rider_id": current_user.id, "trip_id": @trip.id, "confirmed": true}
    @request = Request.create(request_hash)
    Request.where(rider_id: @request.rider_id, confirmed: false).each { |r| r.destroy } #delete previous requests created by the owner
    redirect_to trip_path(@trip)
  end

  def edit

  end

  def update
    @trip.update_attributes(params[:trip])
    redirect_to trip_path(@trip)
  end

  def index
    if !params[:search].present?
      @trips = Trip.includes(:driver).where(status: 'created')
    else
      trips = Array.new
      Trip.all.each do |trip|
        if trip.status == 'created' && trip.goes_through?(params[:search])
          trips.push(trip)
        end
      end
      @trips = trips
    end
    @trips
  end

  def show
    @trip = Trip.includes(:requests).joins(:driver).find(params[:id])
    @path = @trip.via.split(',')
  end

  def destroy
    @trip.cancel_trip
    MailWorker.perform_async('cancel', @trip.id)
    redirect_to trips_path
  end

  def seat_change
    if params[:mode] == 'inc'
      @trip.change_available_seats(true)
    else
      @trip.change_available_seats(false) if @trip.available_seats > 0
    end
    redirect_to trip_path(@trip)
  end

  def search

    redirect_to trips_path
  end

  def finish
    @trip.finish_trip
    redirect_to root_path
  end

  private

    def set_trip
      @trip = Trip.find(params[:id])
    end

end
