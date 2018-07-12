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
end
