#threads

#1
def wait_on_threads(threads)
  threads.each(&:join)
end

#2
def wait_on_threads(threads)
  until threads.none?(&:alive?) do
  end
end

#3
def wait_on_threads(threads)
  loop do 
    if threads.each.map {|t| t.alive?}.none?
      break
    end
  end
end

#mine
def wait_on_threads(threads)
  threads.each { |t|t.value }
end