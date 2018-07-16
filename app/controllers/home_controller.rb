class HomeController < ApplicationController

	def index
		if user_signed_in?
			if current_user.has_trip?
				redirect_to trip_path(current_user.get_trip)
			end
		end
	end

end
