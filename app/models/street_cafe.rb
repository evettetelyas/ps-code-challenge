class StreetCafe < ApplicationRecord
	validates_presence_of :name, :address, :post_code, :chairs
end