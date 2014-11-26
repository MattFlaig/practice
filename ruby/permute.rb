# we define a method that accepts one argument str
def check_for_permuted_palindrome(str)

  # we create an empty hash 
  counts = {}
  no_partner_character = 0
  # we loop through all the characters in the string... we will refer to each character as char
  str.each_char do |char|

    # we skip blank characters (we go and process the next character)
    next if char == " "

    # if there is no hash entry for the current character we initialis the 
    # count for that character to zero
    counts[char] = 0 unless counts.include?(char)

    # we increase the count for the current character by 1
    counts[char] += 1

  # we end the each_char loop
  end

  # checking if the counts are not even, and if so, 
  # if there are more than one characters who have no 
  # palindrome-partner, in which case the whole string is no palindrome 
  counts.each_value do |check|
    if check % 2 != 0
      no_partner_character += 1
    end
  end

  if no_partner_character <= 1
    evaluation = "There is a permutation of this string resulting in a palindrome"
  else 
    evaluation = "There is no permutation of this string resulting in a palindrome"
  end

  return counts, evaluation 
  
# end of the method
end

puts(check_for_permuted_palindrome('einnegermitgazellezagtimregennie'))