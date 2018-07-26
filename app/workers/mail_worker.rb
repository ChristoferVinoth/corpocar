class MailWorker

  include Sidekiq::Worker
  def perform(*args)
    trip = Trip.find(args[1]) if args[1].present?
    rider = User.find(args[2]) if args[2].present?
    request = Request.find(args[3]) if args[3].present?
    if args[0].eql?('confirm')
      TripMailer.trip_confirm_mail(rider, trip).deliver
    elsif args[0].eql?('request')
      TripMailer.trip_request_mail(rider, trip, request).deliver
    elsif args[0].eql?('cancel')
      requests = Request.where(trip_id: trip.id)
        requests.each do |request|
          TripMailer.trip_cancel_mail(request.rider, trip).deliver
          request.destroy
        end
    elsif args[0].eql?('notify')
      trips = Trip.where(status: 'created')
      trips.each do |trip|
        if DateTime.now.utc >= trip.start_time-120
          requests = Request.where(trip_id: trip.id, confirmed: true)
          requests.each do |request|
            TripMailer.trip_notify_mail(request.rider,trip).deliver
          end
        end
      end
    else

    end
  end

end
