class Request < ActiveRecord::Base
  belongs_to :rider, class_name: "User"
  belongs_to :trip
  attr_accessible :trip_id, :rider_id, :confirmed

  validates :trip_id, :rider_id, presence: true

    def self.set_request_values user_id, trip_id
      request = Request.new
      request.rider_id = user_id
      request.trip_id = trip_id
      request.save
      request
    end

    def request_confirmation rider_id
      self.confirmed = true
      self.save
      Request.where(rider_id: rider_id, confirmed: false).each { |r| r.destroy } # deleting other requests made by this rider
    end

end
