desc "Imports CSV data to cafes table"

task :import => :environment do
	CSV.foreach("./db/raw_data/Street Cafes 2015-16.csv", headers: true, encoding:'iso-8859-1:utf-8') do |row|
		StreetCafe.create!(name: row["Café/Restaurant Name"], 
								address: row["Street Address"], 
								post_code: row["Post Code"], 
								chairs: row["Number of Chairs"].to_i)
	end
end