#open file and read it in 
#do the timing of the benchmarks

require 'benchmark'
require './dictionary.rb'

$:.unshift File.dirname(__FILE__)

text = 'texts/ulysses.txt'


dictionary = 'dictionaries/large'

# benchmark storing dictionary in memory (hash table)
sload_time = Time.now
loaded = load(dictionary)
eload_time = Time.now

load_time = (eload_time - sload_time)


abort("Couldn't load #{dictionary}") unless loaded


text_fp = File.open(text, mode = "r")

abort("Couldn't open #{text}") if text_fp == nil


puts "\nMISSPELLED WORDS"

index = 0
misspellings = 0
words = 0
word = String.new
check_time = 0

# !!!!! ___ -- ISSUE OF representation of string (\0 terminator or not??)
#
# Basic strategy: read in words (whitespace delimited????) by byte(?) 
# 	check if letter or apostrophe
# 	if word extends beyond LENGTH, consume and move to next word
# 	need some sort of buffer read
# CHECK IS CALLED ON EACH WORD, SO THE TIMER MUST BE UPDATED BY A += CALL

def isalpha?(char)
	!char.match(/[^[:alpha:]]/)
end

def isdigit?(char)
	!char.match(/[^0-9]/)
end

# open file - read in char by char, if no number, not over 45, 
# and hit whitespace (or newline), you've got a word, store it, check it

text_fp.each_char do |c|

	if isalpha?(c) || c == "'"
		word << c
		index += 1

		if (index > LENGTH)

			# want to "consume" the word and move to the next
			x = text_fp.getc
			while x != " " && x != "\n"
				x = text_fp.getc
			end

			index = 0
			word = ""
		end

	elsif isdigit?(c)

		# want to "consume" the word and move to the next
		x = text_fp.getc
		while x != " " && x != "\n"
			x = text_fp.getc
		end

		index = 0
		word = ""

	elsif index > 0
		# we found a word, count it
		words += 1

		scheck_time = Time.now
		misspelled = !check(word)   # might need to throw a terminating character on? \n? not NUL terminator
		echeck_time = Time.now

		# add timer to tally (added up for all the words for report at end)
		check_time += (echeck_time - scheck_time) 

		if misspelled
			puts "#{word}"
			misspellings += 1
		end

		index = 0
		word = ""
	end
end

puts "***********************************"
puts "\n\nCheck time = #{check_time} seconds\nLoad Time = #{load_time} seconds"
puts "Words in Dictionary = #{@@counter}\nMisspellings = #{misspellings}"


