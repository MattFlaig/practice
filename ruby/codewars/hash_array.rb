#hash_array

#1
def capital(capitals_hash_array)
  capitals_hash_array.map {|cc| "The capital of #{cc[:state] || cc['state'] || cc[:country] || cc['country']} is #{cc[:capital] || cc['capital']}"}
end


#2
def capital(capitals_hash_array)
  capitals_hash_array.map do |data|
    "The capital of #{data.search(:state, :country)} is #{data.search(:capital)}"
  end
end

class Hash
  def search(*keys)
    keys.each do |key|
      value = self[key] || self[key.to_s]
      return value if value
    end
  end
end


#3
class Hash
  def symbolize_keys
    Hash[map{|(k,v)| [k.to_sym,v]}]
  end
end

def capital(capitals_hash_array)
  capitals_hash_array.map(&:symbolize_keys).map do |hash|
    "The capital of #{hash[:country] || hash[:state]} is #{hash[:capital]}"
  end
end



#mine
def capital(hash_array)
  output = [] 
  hash_array.each do |hash|
    hash = Hash[hash.map { |k, v| [k.to_s, v] }]
    output << "The capital of #{hash['state'] || hash['country']} is #{hash['capital']}"
  end
  return output
end