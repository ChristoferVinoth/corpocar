class Trip < ActiveRecord::Base
  has_one :driver, class_name: "User"
  has_many :riders, through: :requests, class_name: "User"
  has_many :requests
  attr_accessible :driver_id, :origin, :destination, :start_time, :available_seats
end
 
