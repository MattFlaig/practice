#cooking_eggs

#1
def cooking_time(eggs)
  (eggs/8.0).ceil * 5
end


#2
def cooking_time(eggs)
  (eggs + 7) / 8 * 5
end


#3
def cooking_time(eggs)
  eggs == 0 ? 0 : ((eggs / 8) + (eggs%8 > 0 ? 1 : 0)) * 5
end



#mine
def cooking_time(eggs)
  time = (eggs / 8).to_i * 5
  eggs % 8 == 0 ? time : time + 5
end