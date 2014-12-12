# dice roll

#1
def get_score dice
  arr = Array.new(7,0)
  dice.each{ |x| arr[x]+=1 }
  result = 0
  score_of_three = [0,1000,200,300,400,500,600]
  if arr.count(1) == 6 then return 1000 end
  if arr.count(2) == 3 then return 750 end
  (1..6).each do |i|     
  result += score_of_three[i]*(arr[i]-2) if arr[i] > 2
  end 
  result += 100 * arr[1] if arr[1] < 3
  result +=  50 * arr[5] if arr[5] < 3
  result == 0 ? "Zonk" : result
end


#2
def get_score dice 
    base = [100,20,30,40,50,60]
    numdice = [0,0,0,0,0,0]
    pairs = 0;
    score = 0
    dice.each { |die| numdice[die-1] += 1 }
    # straight
    return 1000 if dice.length == 6 and numdice.max == numdice.min
    # (3+)-of-a-kind
    numdice.each_index { |i| 
        if numdice[i] > 2 then
            score += base[i] * 10 * (numdice[i] - 2);
            numdice[i] = 0;
        end
        pairs += 1 if numdice[i] == 2
    }
    # three pairs
    return 750 if pairs == 3
    # single ones and fives
    score += numdice[0] * base[0] + numdice[4] * base[4];
    score > 0 ? score : 'Zonk'
end


#3
def get_score dice 
  return 1000 if dice.sort == [1,2,3,4,5,6]
  return 750 if dice.length == 6 and dice.all? { |n| dice.count(n) == 2 }
  base = [nil, 1000, 200, 300, 400, 500, 600]
  score = 0
  (1..6).each do |roll|
    if dice.count(roll) > 2
      score += base[roll] * (dice.count(roll)-2)
      dice.delete(roll)
    end
  end
  case dice.count(1)
    when 1 then score += 100
    when 2 then score += 200
  end
  case dice.count(5)
    when 1 then score += 50
    when 2 then score += 100
  end
  score != 0 ? score : "Zonk"
end


#mine
def get_score dice 
  sum = 0
  pairs = 0
  rolls = [[],[],[],[],[],[]]
  count_hash = { "1"=> 1000, "2"=> 200, "3"=> 300, "4"=> 400, "5"=> 500, "6" => 600 }
 
  if dice.uniq.length == 6
    sum += 1000
  else
    dice.each { |dice_roll| rolls[dice_roll - 1].insert(0, dice_roll) }
    
    rolls.each_with_index do |roll, index|
      if roll.length >= 3 
        count_hash.each_pair do |key, value|
          if roll.length > 3
            sum += (roll.length-2) * value if roll[0].to_s == key 
          else  
            sum += value if roll[0].to_s == key
          end
        end
      elsif roll.length == 2 
        pairs += 1
        sum += 750 if pairs == 3
      end
    end
    
    if pairs < 3
      special_rolls = [rolls[0], rolls[4]]
      special_rolls.each do |special|
        if special.length < 3
          sum += special.length * 100 if special[0] == 1
          sum += special.length * 50 if special[0] == 5
        end
      end
    end
  end
   
  sum > 0 ? sum : "Zonk"
end