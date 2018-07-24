class MailWorker

  include Sidekiq::Worker
  def perform(*args)
    trip = Trip.find(args[1])
    rider = User.find(args[2]) if args[2].present?
    if args[0].eql?('confirm')
      TripMailer.trip_confirm_mail(rider,trip).deliver
    elsif args[0].eql?('request')
      TripMailer.trip_request_mail(rider, trip).deliver
    elsif args[0].eql?('cancel')
      requests = Request.where(trip_id: trip.id)
        requests.each do |request|
          TripMailer.trip_cancel_mail(request.rider, trip).deliver
          request.destroy
        end
    else
    end
  end

end
