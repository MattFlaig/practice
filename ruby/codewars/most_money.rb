#most money 



#1
class Student
  def total_money
    (fives * 5) + (tens * 10) + (twenties * 20)
  end
end

def most_money(students)
  return "all" if students.length > 1 && students.map(&:total_money).uniq.length == 1
  students.max_by(&:total_money).name
end



#2
class Student
  def money
    5 * fives + 10 * tens + 20 * twenties
  end
end

def most_money(students)
  max = students.max_by &:money
  students.count { |s| s.money == max.money } > 1 ? "all" : max.name
end



#3
class Student
  attr_reader :name
  attr_reader :fives
  attr_reader :tens
  attr_reader :twenties

  def initialize(name, fives, tens, twenties)
    @name = name
    @fives = fives
    @tens = tens
    @twenties = twenties
  end
  
  def total
    fives*5 + tens*10 + twenties*20
  end
end

def most_money(students)
  if students.length ==1
    return students[0].name
  end
  
  if students.uniq(&:total).length == 1
    'all'
  else
    students.max_by(&:total).name
  end
end



#mine
class Student
  attr_reader :name
  attr_reader :fives
  attr_reader :tens
  attr_reader :twenties

  def initialize(name, fives, tens, twenties)
    @name = name
    @fives = fives
    @tens = tens
    @twenties = twenties
  end
  
end

def most_money(students)
  stud_name = ""
  sum = 0
  students.each do |student|
    new_sum = student.fives * 5 + student.tens * 10 + student.twenties * 20
    if new_sum > sum
      sum = new_sum
      stud_name = student.name
    elsif new_sum == sum
      stud_name = "all"
    end
  end
  stud_name
end