class Rest < ActiveRecord::Base
  belongs_to :Zone
  has_many :Schedule
  has_secure_password
end
