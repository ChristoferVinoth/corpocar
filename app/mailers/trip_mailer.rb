class TripMailer < ApplicationMailer

	def trip_confirm_mail(rider, trip)
		@rider = rider
		@trip = trip
		mail(to: @rider.email, subject: "Trip Confirmed - #{trip.driver.name}")
	end

	def trip_request_mail(rider, trip, request)
		@rider = rider
		@trip = trip
		@driver = trip.driver
		@request = request
		mail(to: @driver.email, subject: "Trip Request - #{@rider.name}")
	end

	def trip_cancel_mail(rider, trip)
		@rider = rider
		@trip = trip
		mail(to: @rider.email, subject: "Trip Cancelled - #{trip.driver.name}")
	end

end
