class Event <ActiveRecord::Base
 validates :description, :presence => true
 # validates :description, :presence => true, format: { with: /\A[a-zA-Z]+\z/, message: "Only letters allowed" }
 validates :location, :presence => true
 # validates :location, :presence => true, format: { with: /\A[0-9a-zA-Z]*\Z/, message: "Only letters  and numbersallowed" }
 validates :start_date, :presence => true
 validates :end_date, :presence => true
 validates :start_time, :presence => true
 validates :end_time, :presence => true


end
