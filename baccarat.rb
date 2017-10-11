#need variable shoe cut and variable amount of burn cards

shoe_cut = 14
puts "shoe cut snoqualmie standards is 14"
# 1 card then cut card then 5 cards, 6 cards. 3 remain in max case. 

def new_shoe (shoe_cut)
	# deck of 52 cards
	deck = [1,2,3,4,5,6,7,8,9,10,10,10,10,
		1,2,3,4,5,6,7,8,9,10,10,10,10,
		1,2,3,4,5,6,7,8,9,10,10,10,10,
		1,2,3,4,5,6,7,8,9,10,10,10,10]
	# 8 decks are in a baccarat shoe.
	shoe = deck * 8
	# shuffle the shoe.
	shoe = shoe.shuffle
	# insert a "cut card". One more hand will be played when the cut card 
	# is next to be played or if pulled during a hand. 
	shoe.insert(shoe_cut,"Cut Card")
	# First card of the shoe is pulled and a corresponding number of 
	# cards will be burned.
	puts shoe.last
	shoe.last.times {shoe.delete_at(shoe.size - 1)}
	print shoe
	puts "shoe size is #{shoe.size}"
	#abort
	return shoe
end


def deal_hand(shoe)
	p=[shoe.pop]
	b=[shoe.pop]
	p.push(shoe.pop)
	b.push(shoe.pop)

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
					puts "T, Banker at #{(b[0] + b[1] + b[2]) % 10} and player at #{(p[0] + p[1] + p[2]) % 10}"
				end
			else 
				if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1]) % 10)
					puts "PW"
				elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1]) % 10)
					puts "BW"
				else
					puts "T, Banker at #{(b[0] + b[1]) % 10} and player at #{(p[0] + p[1] + p[2]) % 10}"
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
					puts "T, Banker at #{(b[0] + b[1] + b[2]) % 10} and player at #{(p[0] + p[1] + p[2]) % 10}"
				end
			else 
				if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1]) % 10)
					puts "PW"
				elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1]) % 10)
					puts "BW"
				else
					puts "T, Banker at #{(b[0] + b[1]) % 10} and player at #{(p[0] + p[1] + p[2]) % 10}"
				end
			end
		elsif ((b[0] + b[1]) % 10 == 3)
			if (p[2] == 8)
				if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1]) % 10)
					puts "PW"
				elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1]) % 10)
					puts "BW"
				else
					puts "T, Banker at #{(b[0] + b[1]) % 10} and player at #{(p[0] + p[1] + p[2]) % 10}"
				end
			else 
				b.push(shoe.pop)
				if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1] + b[2]) % 10)
					puts "PW"
				elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1] + b[2]) % 10)
					puts "BW"
				else
					puts "T, Banker at #{(b[0] + b[1] + b[2]) % 10} and player at #{(p[0] + p[1] + p[2]) % 10}"
				end
			end
		else 
			b.push(shoe.pop)
			if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1] + b[2]) % 10)
				puts "PW"
			elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1] + b[2]) % 10)
				puts "BW"
			else
				puts "T, Banker at #{(b[0] + b[1] + b[2]) % 10} and player at #{(p[0] + p[1] + p[2]) % 10}"
			end
		end
	end
end


def play_shoe(num_hands, shoe)
	begin
		while (num_hands > 0)
			deal_hand(shoe)
			num_hands -= 1
			puts num_hands
		end
		puts "SHOE HAS ENDED"
	rescue Exception => e
		puts e.message
		puts "cut card drawn one more hand"
		deal_hand(shoe)
	end
end

100.times {play_shoe(70,new_shoe(shoe_cut))}

