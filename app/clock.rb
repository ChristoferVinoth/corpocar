require 'clockwork'
require './config/boot.rb'
require './config/environment.rb'


module Clockwork
  every(30.minutes, 'finished works status change'){ TripWorker.perform_async() }
#  every(1.minute, 'notify requesters'){ MailWorker.perform_async('notify') }
end
