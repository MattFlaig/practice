#1

def sequence(&b)
  Enumerator.new do |y|
    i = 0;
    loop do
      y.yield b.call(i)
      i += 1
    end
  end
end


#2
def sequence &b
  s &b
end


#3
class InfiniteSequence
  def initialize &block
    @results = []
    @index = 0
    @method = block
  end
  
  def take n
    while @index < n do
      @results << @method.call(@index)
      @index += 1
    end
    @results[(0..n-1)]
  end
  
  def take_while &block
    if (idx = @results.index {|x| !block.call(x)})
      @results[(0..idx-1)]
    else
      while block.call(next_val = @method.call(@index)) do
        @results << next_val
        @index += 1
      end
      @results
    end
  end
end

def sequence &block
  InfiniteSequence.new(&block)
end


#4
def sequence(&block)
  Enumerator.new do |a|
    n = 0
    loop do
      a << block.call(n)
      n += 1
    end
  end
end