Memo

#1
class Memo < Hash
  def initialize(&block)
    super { |hash,param| hash[param] = block[param] }
  end
end

#2
class Memo
  def initialize(&block)
    @method = block
    @results = {}
  end
  def [](param)
    @results[param] ||= @method.call(param)
  end
end

#3
class Memo
  def initialize(&block)
    @block = block
    @cache = {}
  end
  def [](param)
    return @cache[param] if @cache.key?(param)
    
    @cache[param] = @block.call(param)
    return @cache[param]
  end
end

#4
class Memo
  def initialize(&block)
    @block = block
    @hash = {}
  end
  def [](param)
    @hash[param] ||= @block.call param
  end
end

#mine
class Memo
  def initialize(&block)
    @block = block
    @params_arr = []
  end
  def [](param)
    if @params_arr.include?(param)
      @memoized ||= @block.call(param)
    else
      @params_arr << param
      @memoized = @block.call(param)
    end
  end
  
end