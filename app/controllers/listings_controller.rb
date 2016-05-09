class ListingsController < ApplicationController
 
  before_action :userid


  def index
    @listing = @user.listings.all
  end
 
  def show
    @listing = Listing.find(params[:id])
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
    @listing = @user.listing.find(params[:id])
 
    if @listing.update(listing_params)
      redirect_to @listing
    else
      render 'edit'
    end
  end
 
  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
 
    redirect_to listings_path
  end
 
  
  private
    def userid 
      @user = User.find(params[:user_id])
    end
      
    def listing_params
      params.require(:listing).permit(:property_name, :address, :property_type, :rental, :smoking, :gym, :internet, :tub, :all_tags)
    end
end
