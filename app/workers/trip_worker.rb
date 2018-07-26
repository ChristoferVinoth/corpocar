class TripWorker

  include Sidekiq::Worker

  def perform(*args)
    Trip.all.each do |trip|
      if(trip.start_time < DateTime.now.utc)
        trip.finish_trip
      end
    end
  end

end
