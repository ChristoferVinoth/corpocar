class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_one :trip, dependent: :destroy
  has_many :requests, foreign_key: 'rider_id', dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: {minimum: 3, maximum: 30}
  validates :employee_id, presence: true
  validates :mobile_no, presence: true, uniqueness: true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :employee_id, :mobile_no

  def is_rider?
    return true if self.requests.empty?
    return false if self.requests.first.trip.driver ==  self && self.requests.first.trip.status == 'created'
    true
  end

  def has_trip?
    return true if !self.is_rider?
    requests = Request.where(rider_id: self.id,confirmed: true)
    requests.each {|request| return true if request.trip.status == 'created'}
    false
  end

  def get_trip
    return self.requests.first.trip.id
  end

end
