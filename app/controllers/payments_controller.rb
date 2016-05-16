class PaymentsController < ApplicationController
	before_action :find_reservation
	before_action :authentication_user, only:[:new, :create]

  def new
    @client_token = Braintree::ClientToken.generate
    @reservation = Reservation.find(params[:reservation_id])
    @payment = Payment.new
  end

  def create
    nonce = params[:payment_method_nonce]
    render action: :new and return unless nonce
    
    @result = Braintree::Transaction.sale(
      amount: @reservation.total_price,
      payment_method_nonce: params[:payment_method_nonce]
    )

    # reserve to save the transaction details into database

    if @result.success?
    	flash[:success] = "Congratulations! You did it"
		redirect_to user_listing_reservation_path(current_user, @reservation.listing, @reservation)
    else
    	flash[:alert]= "Something is wrong"
    	redirect_to[:back]
    end
  end
 	
 	
 	private
 	def find_reservation
 		@reservation = Reservation.find(params[:reservation_id])
 	end
 	
 	def authentication_user
 		if @reservation.user_id == current_user.id
 		else
 			flash[:alert] = "Invalid user"
 			redirect_to [:back]
 		end
 	end
end
	