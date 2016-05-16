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
        reservation1= @reservation.id
        @total_price = @reservation.total_price

        ReservationMailer.booking_email(@customer,@host, @reservation.id).deliver_later
        redirect_to user_listing_reservation_path(current_user, @listing, @reservation)
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
    @listing = Listing.find(params[:listing_id])
    @reservations = Reservation.new
  end

  private
  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :total_price)
  end


end
 