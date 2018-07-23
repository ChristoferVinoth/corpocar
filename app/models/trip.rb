class Trip < ActiveRecord::Base
  belongs_to :driver, class_name: "User"
  has_many :riders, through: :requests, class_name: "User"
  has_many :requests
  attr_accessible :driver_id, :origin, :destination, :start_time, :available_seats

  validates :driver_id, :origin, :destination, :start_time, :available_seats, presence: true

  def self.set_trip_values trip_hash, user_id
    trip_hash['driver_id'] = user_id
    trip = Trip.create(trip_hash)
  end

  def change_available_seats increment
    increment == true ? self.update_attribute(:available_seats, self.available_seats + 1) : self.update_attribute(:available_seats, self.available_seats - 1)
  end

  def cancel_trip
    self.update_attribute(:status, 'cancelled')
  end

  def rider_requested? rider_id
    bool = false
    @requests = Request.where(trip_id: self.id)
    @requests.each do |request|
      if request.rider_id == rider_id
        bool = true
      end
    end
    return bool
  end


end
