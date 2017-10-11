require 'csv'

File.open("C:\\Users\\Massimo\\Documents\\sim1.txt") do |f|
	f.each_line do |line|
		player_total = 0.0
		banker_total = 0.0
		tie_total = 0.0
		shoe = line.split(",").map(&:strip)
		shoe.shift
		puts "shoe length is #{shoe.length}"
		shoe.each do |hand|
			if hand=="T" 
				tie_total += 1
			elsif hand=="B"
				banker_total += 1
			elsif hand=="P"
				player_total += 1
			end
		end
		tie_percentage = tie_total/shoe.length
		banker_percentage = banker_total/shoe.length
		player_percentage = player_total/shoe.length
		puts "tie_total = #{tie_total} at #{tie_percentage}%"
		puts "banker_total = #{banker_total} at #{banker_percentage}"
		puts "player_total = #{player_total} at #{player_percentage}"
		puts

		CSV.open("C:\\Users\\Massimo\\Documents\\sim1.csv", "a+") do |csv|
			csv << [tie_percentage, banker_percentage, player_percentage]
		end
	end
end

