class Doctor < ApplicationRecord
	validates :slot_name,:presence => true
	validates :slot_name,:uniqueness=>true
end
