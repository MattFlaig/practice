#convert bits

#1
def convertBits(a,b)
  (a ^ b).to_s(2).chars.count('1')
end


#2
def convertBits(a,b)
  a = a.to_s(2)
  b = b.to_s(2)
  a = a.rjust(b.size, '0').split('')
  b = b.rjust(a.size, '0').split('')
  a.zip(b).collect do |a, b|
    a == b ? 0 : 1
  end.reduce(:+)
end


#3
def convertBits a,b
  bits = [a.to_s(2), b.to_s(2)]
  len = bits.max_by { |x| x.length }.length
  bits.map! { |x| x.rjust(len, '0').chars }
  bits.transpose.map { |x| x.uniq }.count { |x| x.length == 2 }
end

#mine
def convertBits(a,b)
  counter = 0
  a_bin = a.to_s(2)
  b_bin = b.to_s(2)
  distance = a_bin.length - b_bin.length
  
  if (distance > 0)
    while distance != 0
      b_bin = "0" + b_bin  
      distance -= 1
    end
  elsif (distance < 0)
    while distance != 0
      a_bin = "0" + a_bin
      distance += 1
    end
  end
 
  a_bin.each_char.with_index { |c, i| counter += 1 unless c == b_bin[i] }
  counter
end