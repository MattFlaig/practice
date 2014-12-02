#FIZZBUZZ

# 1
def fizzbuzz(n)
  (1..n).map { |x|
    if ( x % 3 == 0 and x % 5 == 0 ) then 'FizzBuzz'
    elsif ( x % 3 == 0 ) then 'Fizz'
    elsif ( x % 5 == 0 ) then 'Buzz'
    else x
    end
  }
end



# 2
def fizzbuzz(n)
  (1..n).map { |x| x%15==0 ? "FizzBuzz" : x%5==0 ? "Buzz" : x%3==0 ? "Fizz" : x }
end



# 3
def fizzbuzz(n)
  (1..n).map { |x| 
    y = ''
    y += 'Fizz' if x % 3 == 0
    y += 'Buzz' if x % 5 == 0
    y == '' ? x : y
  }
end



# own solution
def fizzbuzz(num)
  if num >= 1
    arr = (1..num).to_a
    arr.each_with_index do |element, index|
      if element % 3 == 0 && element % 5 != 0
        arr.delete_at(index)
        arr.insert(index, "Fizz")
      elsif element % 3 != 0 && element % 5 == 0
        arr.delete_at(index)
        arr.insert(index, "Buzz")
      elsif element % 15 == 0
        arr.delete_at(index)
        arr.insert(index, "FizzBuzz")
      end
    end
  end
  arr
end