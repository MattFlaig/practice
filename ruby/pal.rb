def palindrome(str)
  check_string = str.dup
	left_index = 0
	right_index = (str.length) - 1

	while (left_index < right_index)
    temp_sub = str[left_index]
    str[left_index] = str[right_index]
    str[right_index] = temp_sub
    left_index += 1
    right_index -= 1
  end

  if str == check_string
  	answer = "#{check_string} is a palindrome!"
  else
  	answer = "I am sorry, but #{check_string} is no palindrome!"
  end

  return answer
end


#puts(palindrome("abba"))