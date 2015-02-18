#tick toward

#1
def tick_toward(start, target)
  rv = [start]
  next_tick = start
  until next_tick == target do
    next_tick = next_tick.map.with_index {|x, i| x > target[i] ? x - 1 : x < target[i] ? x + 1 : x}
    rv << next_tick
  end
  rv
end


#2
def tick_toward(start, target)
  def nextval(val, target)
    return val < target ? val + 1 : val > target ? val - 1 : val
  end
  result = [start]
  while result[-1] != target
    result << [ nextval(result[-1][0], target[0]), nextval(result[-1][1], target[1]) ]
  end
  result
end


#3
def ticktoward p1, p2
  x_direction = p2[0] <=> p1[0]
  y_direction = p2[1] <=> p1[1]
  result = [p1]
  x,y = result.last
  loop do
    break if [x,y] == p2
    x += x_direction if x != p2[0]
    y += y_direction if y != p2[1]
    result << [x,y]
  end
  result
end

def tick_toward *args
  ticktoward *args
end


#mine
def tick_toward(start, target)
  result = [start]
  start_x,start_y = start[0],start[1]
  target_x,target_y = target[0],target[1]

  until start_x == target_x && start_y == target_y
    start_x += 1 if start_x < target_x; start_y += 1 if start_y < target_y
    start_x -= 1 if start_x > target_x; start_y -= 1 if start_y > target_y 
    result << [start_x, start_y]
  end
  
  result
end