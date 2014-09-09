def get_closing_parens(str)
  first_position = (str.index('('))+1
  last_position = (str.rindex(')'))+1
  return first_position, last_position
end

puts(get_closing_parens("Sometimes (when I nest them (my parentheticals) too much (like this (and this))) they get confusing."))