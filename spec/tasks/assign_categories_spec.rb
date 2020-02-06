require 'rails_helper'
require 'rake'
PsCodeChallenge::Application.load_tasks

RSpec.describe 'assign categories rake task' do
	before :all do
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
end