LENGTH = 45
HASHTABLE_SIZE = 65536
HASHTABLE = Array.new(HASHTABLE_SIZE)
@@counter = 0  # use to easily implement a size method from a counter in the load method

=begin
in ruby, should have array of size HASHTABLE_SIZE
indexes are hash values, and the "head" of a singly linked list 
should be stored in	the array (additional nodes can be prepended)

hashing and checking need to hash word, get array index, probe at index
	
=end

class Node 
	attr_accessor :data, :next

	def initialize(data)
		@data = data
	end
end

=begin
class Sll
	attr_accessor :head, :count

	def initialize
		@head = Node.new(nil)

		@head.next = nil
		@count = 1
	end
end
=end


def hashes(word)
	h = 5381
	# can use .ord to get ASCII representation of letter (gotten by indexing word) or just .each_byte
	word.each_byte do |b|
		h = ((h << 5) + h) + b
	end
	
	h = h % HASHTABLE_SIZE
	return h
end

#check

def check(text_word)
	@text_word = text_word
	# see if bitwise helps
	text_word.to_lower!

	#check hash table 
	cursor = Node.new(nil)
	cursor.next = HASHTABLE[hashes(@text_word)]

	if cursor.next != nil
		while true
			if (@text_word == cursor.next.data)
				return true
			elsif cursor.next.next == nil
				return false
			end
			cursor.next = cursor.next.next
		end
	else
		return false
	end
end




#load
# open in dictionary - read in word,
def load(dict_file)
	
	fp = File.open(dict_file, mode ="r")
	if fp == nil
		puts "The file couldn't be opened."
		return false
	end

	fp.each_line do |word|
		new_ptr = Node.new(nil)
		new_ptr.data = word

		new_ptr.next = HASHTABLE[hashes(new_ptr.data)]
		HASHTABLE[hashes(new_ptr.data)] = new_ptr

		@@counter += 1
	end
end






#size
def size
	if @@counter > 0
		@@counter
	else
		0
	end
end







