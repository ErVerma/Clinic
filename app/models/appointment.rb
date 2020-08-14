class Appointment < ApplicationRecord
	validates :slot_name,:presence => true

end
