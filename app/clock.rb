require 'clockwork'
require './config/boot.rb'
require './config/environment.rb'


module Clockwork
  every(1.hour, 'finished works status change'){ TripWorker.perform_async() }
end
