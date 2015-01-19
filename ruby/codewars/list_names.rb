#list names

#1
def list names
  names = names.collect { |i| i[:name] }
  sentence = names[0..-2].join(", ") + " & " + names[-1].to_s if names.size > 1
  sentence ||= names.first
end

#2
def list names
  names.map {|x| x[:name]}.join(', ').reverse.sub(',','& ').reverse
end

#3
def list names
  case names.length
    when 0 then ''
    when 1 then names[0][:name]
    when 2 then "#{names[0][:name]} & #{names[1][:name]}"
    else "#{names[0][:name]}, #{list names[1..-1]}"
  end
end


#mine
def list names
  output = ""
  names.each do |n| 
    if n==names[0] 
      output += n[:name]
    elsif n==names[-1]
      output += " & " + n[:name]
    else
      output += ", " + n[:name]
    end
  end
  output  
end