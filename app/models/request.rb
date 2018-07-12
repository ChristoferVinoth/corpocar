class Request < ActiveRecord::Base
  belongs_to :rider, class_name: "User"
  belongs_to :trip
end
