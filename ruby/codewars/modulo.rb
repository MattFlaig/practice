# modulo without %

#1
def solution(n)
  n & 15
end


#2
def solution(n)
  remainder = (1..n).each_slice(16).to_a.last.count
  remainder == 16 ? 0 : remainder
end


#3
def solution(n)
  n.to_s(16).split('').last.hex
end


#mine
def solution(n)  
  arr = Array.new(n)
  16.times { arr.shift } while arr.length > 15
  arr.length
end