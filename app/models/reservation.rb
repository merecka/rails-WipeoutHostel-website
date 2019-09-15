class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :room

	def self.total_cost
		room = Room.find_by(id: self.room.id)
		days = self.check_out - self.check_in
		self.total = room.cost * days
		binding.pry
	end

end