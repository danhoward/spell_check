LENGTH = 45
HASHTABLE_SIZE = 65536


=begin
in ruby, should have array of size HASHTABLE_SIZE
indexes are hash values, and the "head" of a singly linked list 
should be stored in	the array (additional nodes can be appended)

hashing and checking need to hash word, get array index, probe at index
	
=end

class Node 
	attr_accessor :data, :next

	def initialize(data)
		@data = data
	end
end

class Sll
	attr_accessor :head, :count

	def initialize
		@head = Node.new(nil)

		@head.next = nil
		@count = 1
	end
end

#
def hashes(word)
	h = 5381
	# can use .ord to get ASCII representation of letter (gotten by indexing word) or just .each_byte
	word.each_byte do |b|
		h = ((h << 5) + h) + b
	end
	
	h = h % HASHTABLE_SIZE
end







