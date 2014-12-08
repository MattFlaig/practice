#Hashtag

#1
class String
  def hashtags
    scan /#\w+/
  end 
end



#2
class String
  def hashtags
    self.scan(/#[a-z_]/)
  end
end


#3
class String
  def hashtags
    self.match(/#\w+/) || []
  end
end



#mine
class String
  def hashtags
    arr = self.split
    tags = []
    arr.each do |element|
      if element[0] == "#" && element[1]
        tags << element
      end 
    end
    return tags
  end
end
