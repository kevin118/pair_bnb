class ChangePlacesInListings < ActiveRecord::Migration
  def change
  	remove_column :listings, :places, :string
    add_column :listings, :places, :json
  end
end
