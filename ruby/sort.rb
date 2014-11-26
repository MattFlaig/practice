def number_sort(arr)
  return arr if arr.length < 1

  middle = arr.pop
  less = arr.select{|x| x < middle}
  more = arr.select{|x| x >= middle}

  number_sort(less) + [middle] + number_sort(more)
end

nums = [7,3,5,1,9,2,4,8,6]
puts number_sort(nums)


