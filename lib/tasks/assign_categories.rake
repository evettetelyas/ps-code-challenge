desc "Assigns categories to Street Cafes"

task :assign_categories => :environment do
	cafes = StreetCafe.all

	cafes.each do |cafe|
		if cafe.post_code.include? "LS1"
			case cafe.chairs
			when 0..10
				cafe.update!(category: "ls1 small")
			when 11..99
				cafe.update!(category: "ls1 medium")
			when 100..Float::INFINITY
				cafe.update!(category: "ls1 large")
			end
		elsif cafe.post_code.include? "LS2"
			case cafe.chairs
			when 0..(fifty_percentile_chairs-1)
				cafe.update!(category: "ls2 small")
			when fifty_percentile_chairs..Float::INFINITY
				cafe.update!(category: "ls2 large")
			end
		else
			cafe.update!(category: "other")
		end
		cafe.save
	end
end

private

def fifty_percentile_chairs
	chairs = StreetCafe.ls2.pluck(:chairs).sort
	index = (50.0/100.0 * StreetCafe.ls2.count) - 1
	chairs[index]
end