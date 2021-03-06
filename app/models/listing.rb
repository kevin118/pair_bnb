require 'elasticsearch/model'

class Listing < ActiveRecord::Base

	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

	belongs_to :user
	has_many :taggings 
	has_many :tags, through: :taggings, dependent: :destroy
	has_many :reservations
	has_one :payment

	mount_uploaders :places, PlaceUploader


	enum smoking: { No: '0', Yes: '1' }	

	def all_tags=(names)
  		self.tags = names.split(",").map do |name|
    	Tag.where(name: name.strip).first_or_create!
    	end
  	end


	def all_tags
  		self.tags.map(&:name).join(", ")
	end

	def self.tagged_with(name)
		Tag.find_by_name!(name).listings
	end

end
Listing.import force: true

