class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :rider, foreign_key: "user_id"
  belongs_to :trip
end
