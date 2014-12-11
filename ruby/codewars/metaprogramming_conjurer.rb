# metaprogramming conjurer


#1
class Conjurer
  def self.conjure(*args)
    define_method(*args)
  end
end


#2
class Conjurer
  def self.conjure(name, lbd)
    define_method(name, &lbd)
  end
end


#3
class Conjurer
  def self.conjure(name, body)
    define_method name do
        body.call()
    end
  end
end


#mine
class Conjurer
  def self.conjure(name, lambda)
    define_method name, lambda
  end
end