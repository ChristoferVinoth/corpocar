class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  belongs_to :trip
  has_many :requests

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 30}
  validates :employee_id, presence: true
  validates :mobile_no, presence: true, uniqueness: true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :employee_id, :mobile_no

  def is_rider?
    return false if self.trips.first.driver ==  self
    true
  end

  def is_driver?
    return true if self.trips.first.driver ==  self
    false
  end

  def has_trip?
    return false if self.trips.first.nil?
    true
  end


end
