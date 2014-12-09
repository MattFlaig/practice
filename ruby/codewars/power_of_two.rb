#power of 2


#1
def power_of_two?(x)
  Math.log2(x) % 1 == 0
end

#2
def power_of_two?(x)
  x.to_s(2).scan(/1/).length == 1
end


#3
def power_of_two?(x)
  while x%2==0 do
    x=x/2
  end
  x==1
end


#mine
def power_of_two?(x)
  Math.logb(x, 2) % 1 == 0 ? true : false
end

module Math
  def Math.logb(num, base)
    log(num) / log(base)
  end
end