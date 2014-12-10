#linear function


#1
def get_function sequence
  mod = sequence[1] - sequence[0]
  for i in (0...sequence.length-1)
    return "Non-linear sequence" if sequence[i+1] - sequence[i] != mod
  end
  diff = sequence[1] - mod
  return "f(x) = #{diff}" if mod == 0
  "f(x) = #{mod == 1 || mod == -1 ? (mod == 1 ? '' : '-') : mod}x#{diff == 0 ? '' : diff > 0 ? ' + ' : ' - '}#{diff == 0 ? '' : diff.abs}"
end


#2
def get_function sequence
  diff = sequence[1..-1].zip(sequence[0..-2]).map { |a,b| a-b }
  return 'Non-linear sequence' unless diff.all? { |x| x == diff[0] }
  right_term = case
               when sequence[0] < 0
                 " - #{sequence[0].abs}"
               when sequence[0] > 0
                 " + #{sequence[0]}"
               else
                 ''
               end
  'f(x) = ' + case diff[0]
              when 0
                sequence[0].to_s
              when 1
                'x' + right_term
              when -1
                '-x' + right_term
              else
                diff[0].to_s + 'x' + right_term
              end
end


#3
def get_function sequence
  diff = sequence[1] - sequence[0] 
  sequence.each_with_index { |v, i| return 'Non-linear sequence' unless v == sequence[0] + i * diff }
  "f(x) = #{diff}x + #{sequence[0]}".gsub(" 0x + ", " ").gsub("+ -", "- ").gsub(" 1x", " x").gsub("-1x", "-x").gsub(" + 0", "")
end


#mine
def get_function(sequence)
  diff = sequence[1]-sequence[0]
  diff > 0 ? m_sign = "" : m_sign = "-"
  sequence[0] >= 0 ? b_sign = "+" : b_sign = "-"
  compare = sequence[0].step(4*diff + sequence[0], diff).to_a unless diff == 0 
  
  one_x = "f(x) =" + " " + m_sign + "x"
  more_x = "f(x) =" + " " + diff.to_s + "x"
  height = " " + b_sign + " " + sequence[0].abs.to_s

  if sequence[0] == 0 
      compare == sequence ? (diff.abs == 1 ? one_x : more_x) : "Non-linear sequence"
  elsif sequence.uniq.length != 1
    compare == sequence ? (diff.abs == 1 ? one_x + height : more_x + height) : "Non-linear sequence"
  else
    "f(x) =" + " " + sequence[0].to_s
  end
end