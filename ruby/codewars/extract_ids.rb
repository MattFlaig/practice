#extract ids


#1
def extract_ids(data)
  data.to_s.scan(/:id=>(\d+)/).flatten.map(&:to_i)
end


#2
def extract_ids(data)
  data = [data] unless data.is_a? Array
  
  ids = []
  return ids if data == {}
  
  data.each do |item|
    ids << item[:id]
    ids.concat(extract_ids(item[:items])) unless item[:items].nil?
  end
  
  ids
end


#3
def extract_ids(data,a=[])
  return a if data.size.zero?
  data.values.each do |i|
    if i.is_a? Integer
      a << i
    else
      i.each{|x| extract_ids(x,a)}
    end
  end  
  a
end


#4
def extract_ids(data)
  data.to_s.scan(/\d+/).map(&:to_i)
end


#mine
def extract_ids(data)
  ids = data.to_s.scan(/\d+/)
  ids.map{|s| s.to_i}
end