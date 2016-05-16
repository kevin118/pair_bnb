class ListingsController < ApplicationController

 
  before_action :userid, except:[:tags]


  def index
  @listing = @user.listings.all
  @reservations = Reservation.all

  end
 
  def show
    @listing = Listing.find(params[:id])
    @reservations = @listing.reservations
 
  end
 
  def new
    @listing = @user.listings.build
  end
 
  def edit

    @listing = @user.listings.find(params[:id])
  end
 
  def create
    @listing = @user.listings.new(listing_params)
    @listing.all_tags = listing_params[:all_tags]
 
    if @listing.save
      redirect_to user_listings_path
    else
      render 'new'
    end
  end
 
  def update
    @listing = @user.listings.find(params[:id])
    if @listing.update(listing_params)
      redirect_to user_listings_path
    else
      render 'edit'
    end
  end
 
  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
 
    redirect_to user_listings_path
  end

  def tags
    if params[:tag]
      @listings = Listing.tagged_with(params[:tag])
    end
  end
 
  
  private
    def userid 
      
      @user = User.find(params[:user_id])
    end
      
    def listing_params
      params.require(:listing).permit(:property_name, :address, :property_type, :rental,:price, :smoking, :gym, :internet, :tub, :all_tags, {places:[]})
    end
end
