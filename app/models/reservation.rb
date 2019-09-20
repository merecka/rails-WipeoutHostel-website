class Reservation < ApplicationRecord
	validates :user_id, presence: true, numericality: { only_integer: true }
	validates :room_id, presence: true, numericality: { only_integer: true }
	validates :guests, presence: true, numericality: { only_integer: true }
	validate :valid_checkin_date
	validate :valid_checkout_date

	belongs_to :user
	belongs_to :room

	def self.by_reservation_user(user_id)
		where(user_id: user_id)
	end

	def self.by_reservation_room(room_id)
		where(room_id: room_id)
	end

	def self.by_reservation_user_and_room(user_id, room_id)
		where(user_id: user_id, room_id: room_id)
	end

	private

	def valid_checkin_date
		if  self.check_in != nil && self.check_in < Date.today
			errors.add(:check_in, "date must be today or later.")
		end
	end

	def valid_checkout_date
		if self.check_out != nil && self.check_out <= Date.today
			errors.add(:check_out, "date must be at least one day past today.")
		elsif self.check_out != nil && self.check_out <= self.check_in
			errors.add(:check_out, "date must be at least one day past Check-In date.")
		end
	end

end