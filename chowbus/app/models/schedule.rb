class Schedule < ActiveRecord::Base
  belongs_to :Rest
  belongs_to :Zone
end
