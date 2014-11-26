def bracket_checker(str)
  brackets_hash = {'('=>')', '{'=>'}', '['=>']'}
  openers = brackets_hash.keys
  closers = brackets_hash.values

  openers_stack = []
  str.each_char do |char|
    if openers.include?(char)
    	openers_stack << char
    elsif closers.include?(char)
    	last_unclosed_opener = openers_stack.pop
    	if brackets_hash[last_unclosed_opener] != char
    		return false
    	end
    end

  end

  return openers_stack.empty?
end

puts (bracket_checker('{[]()}'))