class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
		t.integer :user_id
		t.string :property_name
		t.string :address
		t.string :property_type
		t.string :rental
     	t.timestamps null: false
    end
  end
end