def doubled_num(arr)

	#CORRECT ANSWER, BUT THERE IS A BETTER ONE
  # counts = {}
  # arr.each do |element|
  #   counts[element] = 0 unless counts.include?(element)
  #   counts[element] += 1
  #   if counts[element] == 2
  #     return element
  #   end
  # end

  #BETTER ANSWER 
  unique_sum = (arr.first..arr.last).reduce(:+)
  doubled_sum = (arr).reduce(:+)
  return doubled_element = doubled_sum - unique_sum
end

puts(doubled_num([1,2,3,4,5,9,6,7,8,9,10]))