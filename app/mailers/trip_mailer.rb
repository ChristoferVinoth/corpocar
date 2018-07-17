class TripMailer < ActionMailer::Base
	default from: "corpocarv1@gmail.com"

	def trip_confirm_mail(user, trip)
		@user = user
		@trip = trip
		mail(to: @user.email, subject: "Trip Confirmed - #{trip.driver.name}")
	end
end
