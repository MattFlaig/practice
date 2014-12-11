#create phone number


#1
def createPhoneNumber(array)
  '(%d%d%d) %d%d%d-%d%d%d%d' % array
end

#2
def createPhoneNumber(numbers)
  numbers.join.gsub /(\d{3})(\d{3})(\d{4})/, '(\1) \2-\3'
end

#3
def createPhoneNumber(numbers)
  numbers = numbers.dup
  "(###) ###-####".gsub!(/#/) { numbers.shift.to_s }
end

#mine
def createPhoneNumber(numbers)
 string_num = numbers.to_s.scan(/\d/).join('')
 hash = { "0" =>"(", "4" =>")", "5" => " ", "9" => "-" }
 hash.each_pair { |key, value| string_num.insert(key.to_i,value) }
 string_num
end