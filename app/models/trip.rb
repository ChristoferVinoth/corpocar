class Trip < ActiveRecord::Base
  belongs_to :driver, class_name: "User"
  has_many :riders, through: :requests, class_name: "User"
  has_many :requests, dependent: :destroy
  attr_accessible :driver_id, :origin, :destination, :start_time, :available_seats

  def rider_requested?

  end
end
