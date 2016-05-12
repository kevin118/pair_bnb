class ReservationMailer < ApplicationMailer
	def booking_email(customer, host, reservation_id)
		@customer = User.find(customer)
		@host = User.find(host)
		@reservation = Reservation.find(reservation_id)
		@listing = @reservation.listing
		@url = "http://localhost:3000/listings/#{@listing.id}/reservations/#{@reservation.id}"
		mail(to: @host.email, subject: 'There is a booking on your listing')
	end
end
