def find_doubled(arr)
  counts = {}
  arr.each do |element|
    counts[element] = 0 unless counts.include?(element)
    counts[element] += 1
  end

  counts.each do |key, value|
    if value == 2
      return key
    end
  end 
end

puts(find_doubled(["a","b","c","d","r","d"]))