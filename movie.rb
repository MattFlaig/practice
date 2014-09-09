def find_movies(flight_length, movie_lengths)
  movies_found = false

  movie_lengths.each_with_index do |mov1, index1|
  	
  	movie_lengths.each_with_index do |mov2, index2|
  		next if index1 == index2
      movie_sum = mov1 + mov2
      
      if movie_sum == flight_length
      	movies_found = true
      	message = "these two movies match: #{mov1} and #{mov2}"
      	return movies_found, message
      end
    end
  end

  unless movies_found
    return movies_found, message="No movies found for the given flight duration"
  end
end

puts(find_movies(150, [120,100,90,80,170,200,60,75]))