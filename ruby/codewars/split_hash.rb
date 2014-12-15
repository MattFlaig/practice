#split hash

#1
def split_hash_by_key(hash, *args)
  raise Error unless (args - hash.keys).empty?
  hash.slice_before { |k,v| args.include? k }.map { |a| Hash[a] }
end


#2
def split_hash_by_key(hash, *args)
  result = []
  args.each do |d|
    left = hash.take_while{|k,v| k != d}
    if left.size == hash.size then raise 'One of the key given as argument is incorrect!' end
    result << Hash[*left.flatten] unless left.empty?
    hash = hash.drop_while{|k,v| k != d}
  end
  result << Hash[*hash.flatten] unless hash.empty?
end


#3
def split_hash_by_key(hash, *args)
  raise "Error" if not args.all? { |key| hash.has_key? key }
  result = []
  hash.each{ |key, value|
    result.push({}) if result.length == 0 or args.include? key
    result.last[key] = value
  }
  result
end


#mine
def split_hash_by_key(hash, *args) 
  arr = []
  index = 0
 
  while arr.length != args.length + 1   
    if hash.has_key?(args[index])
      first, second = hash.partition {|k,v| k < args[index] }.map { |element| Hash[element] }
      if args.length == 1 || index == args.length-1
        [first, second].each { |element| arr << element unless element == {} }
      else
        arr << first 
        hash = second
        index += 1
      end 
    else
      arr = []
      raise 'One of the key given as argument is incorrect!' 
    end 
  end  
  arr.uniq if arr != []  
end