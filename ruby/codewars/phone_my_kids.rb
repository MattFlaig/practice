#phone my kids

#1
class Mother
  
  def self.inherited(subclass)
    @subclasses ||= []
    @subclasses << subclass
  end
  
  def self.phone_kids
    @subclasses.each(&:phone)
  end
end


#2
class Mother
  @@subclasses = []
  
  def self.inherited klass
    @@subclasses << klass
  end
  
  def self.phone_kids
    @@subclasses.each { |klass| klass.phone }
  end
end


#3
class Mother
  def  self.kids
    ObjectSpace.each_object(Class).select { |kid| kid < Mother }
  end
  
  def self.phone_kids
    kids.each { |kid| kid.phone }
  end
end


#mine
class Mother
  # Add a method (or more) to track all kids
  def self.children
    @children ||= []
  end
  
  def self.inherited(child)
    children << child
  end
  
  def self.phone_kids
    # Call the static method "phone" of all kids
    children.each { |child| child.phone }
  end
end

class Son < Mother
  def self.phone
  end
end

class Daughter < Mother
  def self.phone
  end
end
