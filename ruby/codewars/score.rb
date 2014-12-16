# score

#1
def score( dice )
  score = 0
  (1..6).each do |i|
    counter = dice.select { |n| n == i }
    score =+ (i == 1 ? 1000 : i * 100) if counter.size >= 3
    score += (counter.size % 3) * 100 if i == 1
    score += (counter.size % 3) * 50 if i == 5
  end
  score
end


#2
SCORE_MAP = {
  1 => [0, 100, 200, 1000, 1100, 1200, 2000],
  2 => [0, 0, 0, 200, 200, 200, 400],
  3 => [0, 0, 0, 300, 300, 300, 600],
  4 => [0, 0, 0, 400, 400, 400, 800],
  5 => [0, 50, 100, 500, 550, 600, 1000],
  6 => [0, 0, 0, 600, 600, 600, 1200]
}

def score( dice )
  (1..6).inject(0) do |score, die|
    score += SCORE_MAP[die][dice.count(die)]
  end
end


#3
def score(dice)
  dice.sort.join.gsub(/(\d)\1\1|(1|5)/).inject(0) do |sum, num|
    sum + ($1.to_i * 100 + $2.to_i * 10 ) * (num[0] == '1' ? 10 : 1)
  end
end



#mine
def score( dice )
  arr = Array.new(6,0)
  dice.each {|d| arr[d-1] += 1 }
  three_score = [1000,200,300,400,500,600]
  sum = 0
  arr.each_with_index do |a, i|
    sum += three_score[i] if a >= 3
    a -= 3 if a >= 3 
    sum += 100 * a if i == 0
    sum += 50 * a if i == 4
  end
  sum
end