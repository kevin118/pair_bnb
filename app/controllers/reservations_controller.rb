class ReservationsController < ApplicationController
  
  def index
  end

  def create
    
    @listing = Listing.find(params[:listing_id])    
    @reservation = @listing.reservations.new(reservation_params)
    @reservation.user_id = current_user.id
    
    @customer = @reservation.user_id
    @host = @listing.user_id

    if @reservation.save
        ReservationMailer.booking_email(@customer,@host,@listing).deliver_now
        redirect_to user_listing_path(current_user, @listing)
    else
       flash[:danger]= 'Date is not available. Please choose another date'
       redirect_to (:back)    
    end  
  end

  def show
  	@reservation = Reservation.find(params[:id])
  end

  def edit
  	@reservation = @listing.reservations.find(params[:id])
  end

  def new
    @reservation = @listing.reservations.build
  end

  private
  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out)
  end

end
 