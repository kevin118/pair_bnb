class Reservation < ActiveRecord::Base
	belongs_to :user
	belongs_to :listing
	validate :uniqueness_of_date_range


	def uniqueness_of_date_range
    errors.add(:check_in, "is not available") unless listing.reservations.where("? >= check_in AND ? <= check_out", check_in, check_in).count == 0
    errors.add(:check_out, "is not available") unless listing.reservations.where("? >= check_in AND ? <= check_out", check_out,check_out).count == 0
	end
end
