class StreetCafe < ApplicationRecord
	validates_presence_of :name, :address, :post_code, :chairs
	
	scope :ls2, -> { where("street_cafes.post_code ilike '%LS2%' escape '^'") }
end