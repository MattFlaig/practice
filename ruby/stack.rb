# class Stack

#   attr_accessor :name

#   def initialize(name)
#   	@name = name
#   end


# 	def get_largest(arr)
#     largest = arr[0]
#     arr.each do |l|
#       if l.to_i > largest
#       	largest = l
#       end
#     end
#     return largest
# 	end
# end

# testarray = Stack.new("testarray")
# puts testarray.get_largest([1,2,3,23,8,45,9])


class maxStack
	largestStack = []
	stack = []

	def pushStack(item)
		stack.push(item)
		if item >= largestStack[-1]
			largestStack.push(item)
		end
	end

	def popStack
		item = stack.pop
		if item == largestStack[-1]
			largestStack.pop
		end
		#return item
	end

	def getLargest
		return largestStack[-1]
	end

end