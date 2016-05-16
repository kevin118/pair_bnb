class Reservation < ActiveRecord::Base
	belongs_to :user
	belongs_to :listing
  has_one :payment
	validate :uniqueness_of_date_range

 	def date_difference
    (check_out - check_in).to_i
  	end

  	def total_price
  	self.listing
    pricepn = listing.price
    total_price = date_difference*pricepn
  	end


	def uniqueness_of_date_range
    errors.add(:check_in, "is not available") unless listing.reservations.where("? >= check_in AND ? <= check_out", check_in, check_in).count == 0
    errors.add(:check_out, "is not available") unless listing.reservations.where("? >= check_in AND ? <= check_out", check_out,check_out).count == 0
	end
end
