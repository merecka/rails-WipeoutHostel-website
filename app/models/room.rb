class Room < ApplicationRecord
	has_many :reservations
	has_many :users, through: :reservations

	def self.by_room(room_id)
		self.where(id: room_id)
	end

end