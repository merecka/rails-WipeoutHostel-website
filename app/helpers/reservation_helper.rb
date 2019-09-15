module ReservationHelper

	def days(reservation)
		days = (reservation.check_out - reservation.check_in).to_i
	end

end