#count and group

#1
def get_char_count string
  Hash[string.downcase.split(/\W+/).join("").split("").sort.uniq.group_by{|c| string.downcase.count c}.sort_by{|k, v| k}.reverse]
end


#2
def get_char_count string
  (('0'..'9').to_a + ('a'..'z').to_a).inject(Hash.new{|h, k| h[k] = []}) do |result, char|
      result[string.downcase.count(char)] << char if string.downcase.count(char) > 0
      result
  end
end


#3
def get_char_count string
  chars = string.downcase.gsub(/[^a-z\d]/, '').chars.sort
  chars.uniq.group_by { |c| chars.count(c) }
end


#mine
def get_char_count string
  range = [('0'..'9'),('a'..'z')].map{ |r| r.to_a }.flatten
  hash = Hash.new{|h,key| h[key] = [] }
  range.each { |char| counter = string.downcase.scan(char).count;hash[counter].push char if counter != 0}
  hash
end