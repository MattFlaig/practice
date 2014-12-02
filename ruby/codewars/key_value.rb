#KEY_VALUE

#1
def keysAndValues(data)
  [data.keys, data.values]
end

#2
def keysAndValues(data)
  data.to_a.transpose
end

#3
def keysAndValues(data)
  array = []
  array[0] = data.keys
  array[1] = data.values
  array
end

#mine
def keysAndValues(data)
  arr = []
  k = data.keys
  v = data.values
  arr << k
  arr << v
  return arr
end