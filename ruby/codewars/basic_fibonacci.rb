#1
def fibonacci(max)
  
  fib = Enumerator.new do |y|
    a, b = 0, 1 
    loop do 
      y.yield(a)
      a, b = b, a+b
    end
   end
   
   fib.take_while{|el| el <= max}
end

#2
def fibonacci(max)
  fib = [0,1]
  fib.push((fib[-1] + fib[-2])) while fib.max < max
  fib.select{|f|f <= max}
end

#3
def fibonacci(max)
  numbers = [0,1]
  
  while numbers.last <= max
    numbers << numbers[-2,2].reduce(:+)
  end
  numbers.pop
  
  numbers
end

#4
def fibonacci(max)
   
   ary = [0,1]
   max.times do
    new = ary[-1] + ary[-2]
    ary << new if new <= max
   end
   return ary
   
end

#mine
def fibonacci(max)
  counter = 0
  fib_arr = [0]
  while counter < max
    fib_arr.length < 2 ? counter += 1 : counter = fib_arr[-2] + fib_arr[-1]
    fib_arr << counter if counter <= max
  end
  fib_arr
end