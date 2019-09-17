class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :room

	def self.total_cost
		room = Room.find_by(id: self.room.id)
		days = self.check_out - self.check_in
		self.total = room.cost * days
		binding.pry
	end

	def self.by_reservation_user(user_id)
		where(user_id: user_id)
	end

	def self.by_reservation_room(room_id)
		where(room_id: room_id)
	end

	def self.by_reservation_user_and_room(user_id, room_id)
		where(user_id: user_id, room_id: room_id)
	end

end