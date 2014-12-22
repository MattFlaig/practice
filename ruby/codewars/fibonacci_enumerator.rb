#fibonacci enumerator

#1
fib = Enumerator.new do |yielder|
  a, b = 1,1
  
  loop do
    yielder.yield a
    a, b = b, a + b
  end
end


#2
fib = Enumerator.new do |y|
  a,b = 0,1
  loop { y.yield((a,b = b,a+b).first) }
end


#3
fib = Enumerator.new do |y|
  fibs = [1, 1]
  loop do
    fibs << fibs[0] + fibs[1]
    y.yield fibs.shift
  end
end


#mine
fib = Enumerator.new do |f|
  i,j = 1,1
  loop do
    f.yield j
    f << i
    j = i + j
    i = i + j
  end
end