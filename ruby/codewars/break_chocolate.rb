#Break Chocolate

#1
def break_chocolate(n, m)
  n == 0 || m == 0 ? 0 : n * m - 1
end

#2
def break_chocolate(n, m)
  n*m <= 0 ? 0 : n * m - 1
end

#3
def break_chocolate(n, m)
  [n * m - 1, 0].max
end

#mine
def break_chocolate(n, m)
  return n+m > 1 ? (n*m)-1 : 0
end