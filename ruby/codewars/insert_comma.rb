#insert comma


#1
def solution(n)
  n.to_s.reverse.scan(/\d{1,3}/).join(',').reverse
end


#2
def solution(n)
  n.to_s.reverse.gsub(/(...)/, '\1,').reverse
end


#3
def solution(n)
  reversed = n.to_s.chars.reverse
  reversed.map.with_index do |n,i|
    ((i+1) % 3 == 0) && (i+1 != reversed.length) ? [n, ','] : n
  end.flatten.reverse.join
end



#my first solution
def solution(n)
  string_num = n.to_s.reverse
  multiplicator = string_num.length / 3.to_i
  counter = 1  
  while counter <= multiplicator 
    index = counter*3 + counter-1
    string_num.insert(index,",") unless index == string_num.length 
    counter += 1
  end    
  string_num.reverse
end



#my second solution
def solution(n)
  string_num = n.to_s.reverse
  arr_chunks = []
  while (string_num.length != 0)
    arr_chunks << string_num.slice!(0,3)
  end
  comma_number = arr_chunks.join(',')
  comma_number.reverse
end
