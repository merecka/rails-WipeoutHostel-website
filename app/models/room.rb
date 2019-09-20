class Room < ApplicationRecord
	validates :name, presence: true, uniqueness: true
	validates :occupancy, presence: true, numericality: { only_integer: true }
	validates :cost, presence: true, numericality: true

	has_many :reservations
	has_many :users, through: :reservations

	def self.by_room(room_id)
		self.where(id: room_id)
	end

end