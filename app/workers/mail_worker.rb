class MailWorker

  include Sidekiq::Worker
  def perform(*args)
    rider = User.find(args[1])
    trip = Trip.find(args[2])
    if args[0].eql?('confirm')
      TripMailer.trip_confirm_mail(rider,trip).deliver
    elsif args[0].eql?('request')
      TripMailer.trip_request_mail(rider, trip).deliver
    elsif args[0].eql?('cancel')
      TripMailer.trip_cancel_mail(rider, trip).deliver
    else
    end
  end
end
