require 'rails_helper'
require 'rake'
PsCodeChallenge::Application.load_tasks

RSpec.describe 'assign categories rake task' do
	before :each do
		@ls1_cafe_sm = StreetCafe.create(name: "Evette's Cafe", 
															address: "123 Cafe Street", 
															post_code: "LS1 EVT", 
															chairs: 6)
		@ls1_cafe_md = StreetCafe.create(name: "Vanessa's Cafe", 
															address: "123 Theater Street", 
															post_code: "LS1 VSR", 
															chairs: 36)
		@ls1_cafe_lg = StreetCafe.create(name: "Scott's Cafe", 
															address: "123 Snacks Street", 
															post_code: "LS1 SSR", 
															chairs: 140)
		@ls2_cafe_sm = StreetCafe.create(name: "Larry's Cafe", 
															address: "123 Pawsome Street", 
															post_code: "LS2 LAR", 
															chairs: 1)
		@ls2_cafe_sm2 = StreetCafe.create(name: "Larry's Other Cafe", 
															address: "123 Pug Street", 
															post_code: "LS2 LAR", 
															chairs: 2)
		@ls2_cafe_sm3 = StreetCafe.create(name: "Larry's Newer Cafe", 
															address: "123 Cutey Street", 
															post_code: "LS2 LAR", 
															chairs: 10)
		@ls2_cafe_lg = StreetCafe.create(name: "Jason's Cafe", 
															address: "123 Music Street", 
															post_code: "LS2 JSF", 
															chairs: 40)
	end

	it "should assign the proper categories" do
		Rake::Task["assign_categories"].invoke
		@ls1_cafe_sm.reload
		@ls1_cafe_md.reload
		@ls1_cafe_lg.reload
		@ls2_cafe_sm.reload
		@ls2_cafe_lg.reload

		expect(@ls1_cafe_sm.category).to eq("ls1 small")
		expect(@ls1_cafe_md.category).to eq("ls1 medium")
		expect(@ls1_cafe_lg.category).to eq("ls1 large")
		expect(@ls2_cafe_sm.category).to eq("ls2 small")
		expect(@ls2_cafe_lg.category).to eq("ls2 large")
	end

	after :each do
		StreetCafe.delete(@ls1_cafe_sm)
		StreetCafe.delete(@ls1_cafe_md)
		StreetCafe.delete(@ls1_cafe_lg)
		StreetCafe.delete(@ls2_cafe_sm)
		StreetCafe.delete(@ls2_cafe_sm2)
		StreetCafe.delete(@ls2_cafe_sm3)
		StreetCafe.delete(@ls2_cafe_lg)
	end
end