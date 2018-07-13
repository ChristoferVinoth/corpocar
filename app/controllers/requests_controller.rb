class RequestsController < ApplicationController

  def create
    @request = Request.new
    @request.rider_id = current_user.id
    @request.trip_id = params[:trip_id]
    @request.confirmed = false
    @trip = Trip.find(params[:trip_id])
    if @request.save
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
      @requests.each do |r|
        r.destroy
      end 
    end
    render partial: 'trips/requesters'
  end
end
