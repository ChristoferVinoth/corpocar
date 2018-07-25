class RequestsController < ApplicationController

before_filter :authenticate_user!, except:[:confirm_mail]
before_filter :set_trip, except:[:confirm_mail]
before_filter :set_request, except:[:create, :confirm_mail]
before_filter :adjust_seats, only: :destroy

  def create
      @request = Request.set_request_values(current_user.id,@trip.id)
      MailWorker.perform_async('request', @trip.id, @request.rider_id, @request.id)
      render partial: 'trips/requesters'
  end

  def confirm_request
      @request.request_confirmation
      @trip.change_available_seats(false)
      MailWorker.perform_async('confirm', @trip.id, @request.rider_id)
      render partial: 'trips/requesters'
  end

  def confirm_mail
    req = Request.find_by_request_token(params[:token])
    if req
      req.request_confirmation
      redirect_to root_url
    else
      redirect_to root_url
    end
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

    def email_confirm
      self.confirmed = true
      self.request_token = nil
      save!(:validate => false)
    end

end
