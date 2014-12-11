#take while

#1
def take_while list, &block
  
  outputArray = []

  list.each do |i|
      if yield i 
        outputArray << i
      else
        break
      end
  end
  
  outputArray
  
end



#2
def take_while list, &block
   items = []
   list.each {|val| yield(val) ? items << val : (return items)}
end



#3
def take_while list, &block
  taken = []
  enum = list.each
  loop do
    n = enum.next
    raise StopIteration unless block.call(n)
    taken << n
  end
  taken
end



#mine
def take_while list, &block
  list.take_while(&block)
end