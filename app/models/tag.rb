class Tag < ActiveRecord::Base
	has_many :taggings
	has_many :listing, through: :taggings
end
