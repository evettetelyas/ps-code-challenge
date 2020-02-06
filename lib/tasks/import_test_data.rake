desc "Imports dummy data to test db"
Rails.env = 'test'

task :import_test_data => :environment do
	CSV.foreach("./db/raw_data/test_data.csv", headers: true, encoding:'iso-8859-1:utf-8') do |row|
		StreetCafe.create(name: row["name"], 
								address: row["address"], 
								post_code: row["post_code"], 
								chairs: row["chairs"].to_i)
	end
end