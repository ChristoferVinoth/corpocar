class RequestsController < ApplicationController

before_filter :authenticate_user!
before_filter :set_trip
before_filter :set_request, except:[:create]
before_filter :adjust_seats, only: :destroy

  def create
      @request = Request.set_request_values(current_user.id,@trip.id)
      MailWorker.perform_async('request', @trip.id, @request.rider_id)
      render partial: 'trips/requesters'
  end

  def confirm_request
      @request.request_confirmation
      @trip.change_available_seats(false)
      MailWorker.perform_async('confirm', @trip.id, @request.rider_id)
      render partial: 'trips/requesters'
  end

  def destroy
    if @request.destroy
      redirect_to trip_path(@trip)
    end
  end

  private

    def set_trip
      @trip = Trip.find(params[:trip_id])
    end

    def set_request
      @request = Request.find(params[:req_id])
    end

    def adjust_seats
      if @request.confirmed
        @trip.change_available_seats(true)
      end
    end

end
