module ReservationHelper

	def days(reservation)
		days = (reservation.check_out - reservation.check_in).to_i
	end

	def total_cost(reservation)
		room = Room.find_by(id: reservation.room.id)
		days = (reservation.check_out - reservation.check_in).to_i
		if reservation.discount != nil
			reservation.total = (reservation.room.cost * days * (1-reservation.discount))
		else
			reservation.total = (reservation.room.cost * days)
		end
	end

end