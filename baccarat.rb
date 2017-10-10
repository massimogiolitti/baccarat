deck = [0,0,0,0,1,2,3,4,5,6,7,8,9,
	0,0,0,0,1,2,3,4,5,6,7,8,9,
	0,0,0,0,1,2,3,4,5,6,7,8,9,
	0,0,0,0,1,2,3,4,5,6,7,8,9]

shoe = deck * 8

shoe = shoe.shuffle

print shoe
puts

def deal_hand(shoe)
	p=[shoe.pop]
	b=[shoe.pop]
	p.push(shoe.pop)
	b.push(shoe.pop)

=begin
	print p
	puts
	print b
	puts
	print shoe
	puts
=end


#need variable shoe cut and variable amount of burn cards

burn_cards = 1 + rand(9)
puts "burn cards amount is #{burn_cards}"
shoe_cut = 14
puts "shoe cut snoqualmie standards is 14"
# 1 card then cut card then 5 cards, 6 cards. 3 remain in max case. 

	puts "player shows #{(p[0] + p[1]) % 10}"
	puts "banker has #{(b[0] + b[1]) % 10}"

	if (((p[0] + p[1]) % 10 == 9 && (b[0] + b[1]) % 10 == 9) || ((p[0] + p[1]) % 10 == 8 && (b[0] + b[1]) % 10 == 8))
		puts "NT"
	elsif ((p[0] + p[1]) % 10 == 9)
		puts "PN"
	elsif ((b[0] + b[1]) % 10 == 9)
		puts "BN"
	elsif ((p[0] + p[1]) % 10 == 8)
		puts "PN"
	elsif ((b[0] + b[1]) % 10 == 8)
		puts "BN"
	elsif (((p[0] + p[1]) % 10 == 7 && (b[0] + b[1])  % 10 == 7) || ((p[0] + p[1]) % 10 == 6 && (b[0] + b[1]) % 10 == 6))
		puts "T"
	elsif ((p[0] + p[1]) % 10 == 7 && (b[0] + b[1]) % 10 == 6)
		puts "PW BBQ"
	elsif ((p[0] + p[1]) % 10 == 6 && (b[0] + b[1]) % 10 == 7)
		puts "BW BBQ"
	elsif (((p[0] + p[1]) % 10 == 7 || (p[0] + p[1]) % 10 == 6) && (b[0] + b[1]) % 10 < 6)
		puts "player is 6 or 7 and banker is not"
		b.push(shoe.pop)
		puts "banker is now #{(b[0] + b[1] + b[2]) % 10}"
		if ((p[0] + p[1]) % 10 > (b[0] + b[1] + b[2]) % 10)
			puts "PW"
		elsif ((p[0] + p[1]) % 10 < (b[0] + b[1] + b[2]) % 10)
			puts "BW"
		else
			puts "T"
		end
	#MUST DEAL WITH BANKER 6 HIT CASE
	elsif (((b[0] + b[1]) % 10 == 7) && (p[0] + p[1]) % 10 < 6)
		puts "banker is 6 or 7 and player is not"
		p.push(shoe.pop)
		puts "player is now #{(p[0] + p[1] + p[2]) % 10}"
		if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1]) % 10)
			puts "PW"
		elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1]) % 10)
			puts "BW"
		else
			puts "T"
		end
	elsif ((b[0] + b[1]) % 10 == 6 && (p[0] + p[1]) % 10 < 6)
		p.push(shoe.pop)
		if (p[2].between?(6,7))
			b.push(shoe.pop)
			if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1] + b[2]) % 10)
				puts "PW"
			elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1] + b[2]) % 10)
				puts "BW"
			else
				puts "T"
			end
		else 
			if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1]) % 10)
				puts "PW"
			elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1]) % 10)
				puts "BW"
			else
				puts "T"
			end
		end
	elsif ((p[0] + p[1]) % 10 < 6 && (b[0] + b[1]) % 10 < 6)
		puts "both sides are less than 6"
		p.push(shoe.pop)
		if ((b[0] + b[1]) % 10 == 5)
			if (p[2].between?(4,7))
				b.push(shoe.pop)
				if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1] + b[2]) % 10)
					puts "PW"
				elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1] + b[2]) % 10)
					puts "BW"
				else
					puts "T"
				end
			else 
				if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1]) % 10)
					puts "PW"
				elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1]) % 10)
					puts "BW"
				else
					puts "T"
				end
			end

		elsif ((b[0] + b[1]) % 10 == 4)
			if (p[2].between?(2,7))
				b.push(shoe.pop)
				if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1] + b[2]) % 10)
					puts "PW"
				elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1] + b[2]) % 10)
					puts "BW"
				else
					puts "T"
				end
			else 
				if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1]) % 10)
					puts "PW"
				elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1]) % 10)
					puts "BW"
				else
					puts "T"
				end
			end
		elsif ((b[0] + b[1]) % 10 == 3)
			if (p[2] == 8)
				if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1]) % 10)
					puts "PW"
				elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1]) % 10)
					puts "BW"
				else
					puts "T"
				end
			else 
				b.push(shoe.pop)
				if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1] + b[2]) % 10)
					puts "PW"
				elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1] + b[2]) % 10)
					puts "BW"
				else
					puts "T"
				end
			end
		else 
			b.push(shoe.pop)
			if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1] + b[2]) % 10)
				puts "PW"
			elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1] + b[2]) % 10)
				puts "BW"
			else
				puts "T"
			end
		end
	end
end

	
deal_hand(shoe)