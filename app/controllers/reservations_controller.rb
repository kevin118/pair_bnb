class ReservationsController < ApplicationController
  
  def index
  end

  def create
    
    @listing = Listing.find(params[:listing_id])    
    @reservation = @listing.reservations.new(reservation_params)
    @reservation.user_id = current_user
    if @reservation.save! 
    redirect_to user_listing_path(current_user, @listing)
    else
    redirect_to edit_user_listing_path(current_user, @listing)
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
 