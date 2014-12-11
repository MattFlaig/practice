#in sphere


#1
def in_sphere?(coords, radius)
  coords.inject(0){|sum, c| sum += c**2 } <= radius**2
end


#2
def in_sphere?(coords, radius)
  coords.reduce(0) { |s, c| s + c*c } <= radius**2
end

#3
def in_sphere?(coords, radius)
   coords.count == 0 || coords.map { |c| c**2 }.reduce(:+) <= radius**2 
end

#mine
def in_sphere?(coords, radius)
  output = 0
  coords.each{|element|output += element**2} 
  output <= radius**2 ? true : false
end