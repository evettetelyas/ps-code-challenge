require 'rails_helper'
require 'rake'

RSpec.describe 'reassign categories rake task' do
	before :each do
		@ls1_cafe_sm = StreetCafe.create(name: "Evette's Cafe", 
															address: "123 Cafe Street", 
															post_code: "LS1 EVT", 
															chairs: 6,
															category: "ls1 small")
		@ls1_cafe_md = StreetCafe.create(name: "Vanessa's Cafe", 
															address: "123 Theater Street", 
															post_code: "LS1 VSR", 
															chairs: 36,
															category: "ls1 medium")
		@ls1_cafe_lg = StreetCafe.create(name: "Scott's Cafe", 
															address: "123 Snacks Street", 
															post_code: "LS1 SSR", 
															chairs: 140,
															category: "ls1 large")
		@ls2_cafe_sm = StreetCafe.create(name: "Larry's Cafe", 
															address: "123 Pawsome Street", 
															post_code: "LS2 LAR", 
															chairs: 1,
															category: "ls2 small")
		@ls2_cafe_lg = StreetCafe.create(name: "Jason's Cafe", 
															address: "123 Music Street", 
															post_code: "LS2 JSF", 
															chairs: 40,
															category: "ls2 large")
	end

	it "should assign the proper categories" do
		Rake::Task["reassign_cafes"].invoke
		@ls1_cafe_md.reload
		@ls1_cafe_lg.reload
		@ls2_cafe_lg.reload

		expect{StreetCafe.find(@ls1_cafe_sm.id)}.to raise_error(ActiveRecord::RecordNotFound)
		expect{StreetCafe.find(@ls2_cafe_sm.id)}.to raise_error(ActiveRecord::RecordNotFound)
		expect(@ls1_cafe_md.name).to eq("ls1 medium Vanessa's Cafe")
		expect(@ls1_cafe_lg.name).to eq("ls1 large Scott's Cafe")
		expect(@ls2_cafe_lg.name).to eq("ls2 large Jason's Cafe")
	end

	after :each do
		StreetCafe.delete(@ls1_cafe_sm)
		StreetCafe.delete(@ls1_cafe_md)
		StreetCafe.delete(@ls1_cafe_lg)
		StreetCafe.delete(@ls2_cafe_sm)
		StreetCafe.delete(@ls2_cafe_lg)
		File.delete("./db/raw_data/small_cafes.csv")
	end
end