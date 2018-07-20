class Trip < ActiveRecord::Base
  belongs_to :driver, class_name: "User"
  has_many :riders, through: :requests, class_name: "User"
  has_many :requests, dependent: :destroy
  attr_accessible :driver_id, :origin, :destination, :start_time, :available_seats

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