desc "writes small cafes to a new csv, and reassigns name of medium/large cafes"

task :reassign_cafes => :environment do
	cafes = StreetCafe.all
	CSV.open("./db/raw_data/small_cafes.csv", "wb") do |row|
	row << ["Caf�/Restaurant Name","Street Address","Post Code","Number of Chairs","Category"]
		cafes.each do |cafe|
			case
			when (cafe.category.include? "small")
				row << [cafe.name, cafe.address, cafe.post_code, cafe.chairs, cafe.category]
				cafe.delete
			when (cafe.category.include? "large") || (cafe.category.include? "medium")
				cafe.update(name: "#{cafe.category} #{cafe.name}")
				cafe.save
			end
		end
	end
end