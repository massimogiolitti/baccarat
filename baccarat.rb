require 'csv'
class Baccarat
	#need variable shoe cut and variable amount of burn cards
	@shoe_cut = 14
	puts "shoe cut snoqualmie standards is 14"
	@cut_card_pulled = false

	def self.new_shoe()
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
		shoe.insert(@shoe_cut,"Cut Card")
		# First card of the shoe is pulled and a corresponding number of 
		# cards will be burned.
		shoe.last.times {shoe.delete_at(shoe.size - 1)}
		return shoe
	end

	def self.check_cut_card(a, shoe)
		if (a[a.size-1] == "Cut Card")
			a[a.size-1] = shoe.pop
			@cut_card_pulled = true
		end
	end
	#lots of repetitive if statements. will evenetually fix this. 
	def self.deal_hand(shoe)
		hand_outcome = ""
		p=[shoe.pop]
		check_cut_card(p, shoe)
		b=[shoe.pop]
		check_cut_card(b, shoe)
		p.push(shoe.pop)
		check_cut_card(p, shoe)
		b.push(shoe.pop)
		check_cut_card(b, shoe)

		puts "player shows #{(p[0] + p[1]) % 10}"
		puts "banker has #{(b[0] + b[1]) % 10}"

		if (((p[0] + p[1]) % 10 == 9 && (b[0] + b[1]) % 10 == 9) || ((p[0] + p[1]) % 10 == 8 && (b[0] + b[1]) % 10 == 8))
			puts "NT"
			hand_outcome =  "T"
		elsif ((p[0] + p[1]) % 10 == 9)
			puts "PN"
			hand_outcome =  "P"
		elsif ((b[0] + b[1]) % 10 == 9)
			puts "BN"
			hand_outcome =  "B"
		elsif ((p[0] + p[1]) % 10 == 8)
			puts "PN"
			hand_outcome =  "P"
		elsif ((b[0] + b[1]) % 10 == 8)
			puts "BN"
			hand_outcome =  "B"
		elsif (((p[0] + p[1]) % 10 == 7 && (b[0] + b[1])  % 10 == 7) || ((p[0] + p[1]) % 10 == 6 && (b[0] + b[1]) % 10 == 6))
			puts "T"
			hand_outcome =  "T"
		elsif ((p[0] + p[1]) % 10 == 7 && (b[0] + b[1]) % 10 == 6)
			puts "PW BBQ"
			hand_outcome =  "P"
		elsif ((p[0] + p[1]) % 10 == 6 && (b[0] + b[1]) % 10 == 7)
			puts "BW BBQ"
			hand_outcome =  "B"
		elsif (((p[0] + p[1]) % 10 == 7 || (p[0] + p[1]) % 10 == 6) && (b[0] + b[1]) % 10 < 6)
			puts "player is 6 or 7 and banker is not"
			b.push(shoe.pop)
			check_cut_card(b, shoe)
			puts "banker is now #{(b[0] + b[1] + b[2]) % 10}"
			if ((p[0] + p[1]) % 10 > (b[0] + b[1] + b[2]) % 10)
				puts "PW"
				hand_outcome =  "P"
			elsif ((p[0] + p[1]) % 10 < (b[0] + b[1] + b[2]) % 10)
				puts "BW"
				hand_outcome =  "B"
			else
				puts "T"
				hand_outcome =  "T"
			end
		elsif (((b[0] + b[1]) % 10 == 7) && (p[0] + p[1]) % 10 < 6)
			puts "banker is 6 or 7 and player is not"
			p.push(shoe.pop)
			check_cut_card(p, shoe)
			puts "player is now #{(p[0] + p[1] + p[2]) % 10}"
			if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1]) % 10)
				puts "PW"
				hand_outcome =  "P"
			elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1]) % 10)
				puts "BW"
				hand_outcome =  "B"
			else
				puts "T"
				hand_outcome =  "T"
			end
		elsif ((b[0] + b[1]) % 10 == 6 && (p[0] + p[1]) % 10 < 6)
			p.push(shoe.pop)
			check_cut_card(p, shoe)
			if (p[2].between?(6,7))
				b.push(shoe.pop)
				check_cut_card(b, shoe)
				if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1] + b[2]) % 10)
					puts "PW"
					hand_outcome =  "P"
				elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1] + b[2]) % 10)
					puts "BW"
					hand_outcome =  "B"
				else
					puts "T"
					hand_outcome =  "T"
				end
			else 
				if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1]) % 10)
					puts "PW"
					hand_outcome =  "P"
				elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1]) % 10)
					puts "BW"
					hand_outcome =  "B"
				else
					puts "T"
					hand_outcome =  "T"
				end
			end
		elsif ((p[0] + p[1]) % 10 < 6 && (b[0] + b[1]) % 10 < 6)
			puts "both sides are less than 6"
			p.push(shoe.pop)
			check_cut_card(p, shoe)
			if ((b[0] + b[1]) % 10 == 5)
				if (p[2].between?(4,7))
					b.push(shoe.pop)
					check_cut_card(b, shoe)
					if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1] + b[2]) % 10)
						puts "PW"
						hand_outcome =  "P"
					elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1] + b[2]) % 10)
						puts "BW"
						hand_outcome =  "B"
					else
						puts "T, Banker at #{(b[0] + b[1] + b[2]) % 10} and player at #{(p[0] + p[1] + p[2]) % 10}"
						hand_outcome =  "T"
					end
				else 
					if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1]) % 10)
						puts "PW"
						hand_outcome =  "P"
					elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1]) % 10)
						puts "BW"
						hand_outcome =  "B"
					else
						puts "T, Banker at #{(b[0] + b[1]) % 10} and player at #{(p[0] + p[1] + p[2]) % 10}"
						hand_outcome =  "T"
					end
				end

			elsif ((b[0] + b[1]) % 10 == 4)
				if (p[2].between?(2,7))
					b.push(shoe.pop)
					check_cut_card(b, shoe)
					if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1] + b[2]) % 10)
						puts "PW"
						hand_outcome =  "P"
					elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1] + b[2]) % 10)
						puts "BW"
						hand_outcome =  "B"
					else
						puts "T, Banker at #{(b[0] + b[1] + b[2]) % 10} and player at #{(p[0] + p[1] + p[2]) % 10}"
						hand_outcome =  "T"
					end
				else 
					if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1]) % 10)
						puts "PW"
						hand_outcome =  "P"
					elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1]) % 10)
						puts "BW"
						hand_outcome =  "B"
					else
						puts "T, Banker at #{(b[0] + b[1]) % 10} and player at #{(p[0] + p[1] + p[2]) % 10}"
						hand_outcome =  "T"
					end
				end
			elsif ((b[0] + b[1]) % 10 == 3)
				if (p[2] == 8)
					if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1]) % 10)
						puts "PW"
						hand_outcome =  "P"
					elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1]) % 10)
						puts "BW"
						hand_outcome =  "B"
					else
						puts "T, Banker at #{(b[0] + b[1]) % 10} and player at #{(p[0] + p[1] + p[2]) % 10}"
						hand_outcome =  "T"
					end
				else 
					b.push(shoe.pop)
					check_cut_card(b, shoe)
					if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1] + b[2]) % 10)
						puts "PW"
						hand_outcome =  "P"
					elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1] + b[2]) % 10)
						puts "BW"
						hand_outcome =  "B"
					else
						puts "T, Banker at #{(b[0] + b[1] + b[2]) % 10} and player at #{(p[0] + p[1] + p[2]) % 10}"
						hand_outcome =  "T"
					end
				end
			else 
				b.push(shoe.pop)
				check_cut_card(b, shoe)
				if ((p[0] + p[1] + p[2]) % 10 > (b[0] + b[1] + b[2]) % 10)
					puts "PW"
					hand_outcome =  "P"
				elsif ((p[0] + p[1] + p[2]) % 10 < (b[0] + b[1] + b[2]) % 10)
					puts "BW"
					hand_outcome =  "B"
				else
					puts "T, Banker at #{(b[0] + b[1] + b[2]) % 10} and player at #{(p[0] + p[1] + p[2]) % 10}"
					hand_outcome =  "T"
				end
			end
		end
		return hand_outcome
	end

	#if the next 6 cards include the cut card remove cut card, flag, exit loop, run deal_hand once more. 

	def self.play_shoe(shoe)
		@cut_card_pulled = false
		shoe_outcome = []
		while (!@cut_card_pulled)
			shoe_outcome << deal_hand(shoe)
		end
		shoe_outcome << deal_hand(shoe)
		puts "SHOE HAS ENDED"
		return shoe_outcome
	end

	CSV.open("/Users/massimo/desktop/baccarat/bac.csv", "w") do |csv|
		100.times { |n| csv << play_shoe(new_shoe()).insert(0,n+1)}
	end
end
