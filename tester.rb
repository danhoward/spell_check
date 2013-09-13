
def isalpha?(char)
	!char.match(/[^A-Za-z]/)
end

def isdigit?(char)
	!char.match(/[^0-9]/)
end

word = String.new
index = 0
words = 0

#x = "./test.txt"

fp = File.open("./test.txt", mode = "r")


fp.each_char do |c|

	if isalpha?(c) || c == "'"
		word << c
		index += 1

		if (index > 45)

			# want to "consume" the word and move to the next

			index = 0
		end

	elsif isdigit?(c)

		# want to "consume" the word and move to the next
		x = fp.getc
		while x != " " && x != "\n"
			puts "#{fp.pos}   #{x.inspect}"
			x = fp.getc
		end

		word = ""

	elsif index > 0
		# we found a word, count it
		puts "#{word}  #{fp.pos}"
		word = ""
		words += 1
	end

end

puts "#{words}"
