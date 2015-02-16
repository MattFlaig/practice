#roman numerals

#1
NUMERALS = { M: 1000, CM: 900, D: 500, CD: 400, C: 100, XC: 90,
               L: 50, XL: 40, X: 10, IX: 9, V: 5, IV: 4, I: 1 }

def solution(number)
  return '' if number <= 0
  NUMERALS.each { |key, val| return key.to_s + solution(number - val) if number >= val }
end


#2
ROMAN={'M'=>1000,'CM'=>900, 'D'=>500,'CD'=>400,'C'=>100,'XC'=>90,'L'=>50,'XL'=>40,'X'=>10,'IX'=>9,'V'=>5,'IV'=>4,'I'=>1}
def solution(number)
result = ""
  ROMAN.each do |r,v|
    while number >= v
      result << r
      number -= v
    end
  end
  result
end


#3
def solution(number)
  roman=""
 sym_map= {
 1000=>"M",
 900 =>"CM",
 500 =>"D",
 400 =>"CD",
 100 =>"C",
 90  =>"XC",
 50  =>"L",
 40  =>"XL",
 10  =>"X",
 9   =>"IX",
 5   =>"V",
 4   =>"IV",
 1   =>"I"
 }
  sym_map.each{|k,v|
    while(number>=k) do
      roman+=v
      number-=k
    end
  }
  roman
end


#mine
def solution(number)
  result = ''
  hash = {'1000' => 'M', '500' => 'D', '100' => 'C', '50' => 'L', '10' => 'X', '5' => 'V', '1' => 'I' }
  
  thousands = number / 1000.to_i
  hundreds = number % 1000 / 100.to_i
  tens = number % 100 / 10.to_i
  ones = number % 10.to_i
  
  def compute_result(hash, remainder, array)
    result = ''
    if remainder > 5  
      if remainder == 9 
        result += hash[array[2]] + hash[array[0]] 
      else 
        result += hash[array[1]]
        (remainder - 5).times { result += hash[array[2]] } 
      end
    elsif remainder == 5
      result += hash[array[1]]
    else
      remainder == 4 ? result += hash[array[2]] + hash[array[1]] : remainder.times { result += hash[array[2]] }
    end
    result
  end
  
  thousands.times { result += hash['1000'] } 
  result += compute_result(hash, hundreds, ['1000', '500', '100'])if hundreds > 0
  result += compute_result(hash, tens, ['100', '50', '10']) if tens > 0
  result += compute_result(hash, ones, ['10', '5', '1']) if ones > 0
  
  result
end
