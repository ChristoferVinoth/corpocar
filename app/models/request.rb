class Request < ActiveRecord::Base
  belongs_to :rider, class_name: "User"
  belongs_to :trip
  attr_accessible :trip_id, :rider_id, :confirmed

end
