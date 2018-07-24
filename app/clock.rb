require 'clockwork'
require './config/boot.rb'
require './config/environment.rb'


module Clockwork
  every(1.day, 'finished works status change', :at => '00:00'){ TripWorker.perform_async() }
end
