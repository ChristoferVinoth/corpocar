class RequestsController < ApplicationController

before_filter :authenticate_user!

  def create
    @request = Request.new
    @request.rider_id = current_user.id
    @request.trip_id = params[:trip_id]
    @request.confirmed = false
    @trip = Trip.find(params[:trip_id])
    if @request.save
      TripMailer.trip_request_mail(@request.rider, @trip).deliver
      render partial: 'trips/requesters'
    end
  end

  def create_driver_request
    puts "#{params[:id]}"
    @request = Request.new
    @request.rider_id = current_user.id
    @request.trip_id = params[:id]
    @request.confirmed = true
    if @request.save
      @requests = Request.where(rider_id: @request.rider_id, confirmed: false )
      @requests.each do |r|
        r.destroy
      end
      @trip = Trip.find(params[:id])
      redirect_to trip_path(@trip)
    end
  end

  def confirm_request
    @trip = Trip.find(params[:trip_id])
    @request = Request.find(params[:req_id])
    @request.confirmed = true
    if @request.save
      @requests = Request.where(rider_id: @request.rider_id, confirmed: false )
      TripMailer.trip_confirm_mail(@request.rider, @trip).deliver
      @requests.each do |r|
        r.destroy
      end
    end
    if @trip.available_seats
      @trip.available_seats-=1
    end
    @trip.save
    render partial: 'trips/requesters'
  end

  def destroy
    @trip = Trip.find(params[:trip_id])
    @request = Request.find(params[:req_id])
    if @request.confirmed
      @trip.available_seats +=1
    end
    if @request.destroy
      redirect_to trips_path
    end
  end
end
