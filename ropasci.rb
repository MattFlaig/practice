class RockPaperScissors
  attr_accessor :user, :computer, :hands_hash

  def initialize
    @user = User.new
    @computer = Computer.new
    @hands_hash = {'rock' => 'scissors', 'scissors' => 'paper', 'paper' => 'rock'}
  end

  class User
	  attr_accessor :hand
	  def initialize
	    @hand = ''
	  end
  end

	class Computer
		attr_accessor :hand
		def initialize
		  @hand = ''
		end
	end

	def evaluate_hands
	  if user.hand == computer.hand
	  	answer = "It's a tie!"
	  else
			hands_hash.each do |key, value|
		    if user.hand == key && computer.hand == value
		      return answer = "You win!"
		      break 
		    end
			end
		end

		unless answer
			return answer = "You lost!"
		else
      return answer  
    end
	end	

	def choose_hand(player)
    if player == :user
    	puts "Please choose your weapon by typing in either rock, paper, or scissors!"
	    hands = gets.chomp
	  else
	  	hands = hands_hash.keys.sample
	  end
	  hands
	end

	def start
		hands_hash = {'rock' => 'scissors', 'scissors' => 'paper', 'paper' => 'rock'}
	  user.hand = choose_hand(:user)
	  computer.hand = choose_hand(:computer)
	  play_game
	  puts evaluate_hands
	  play_again?
	end

	def play_game
		puts "------------------------------------"
		puts "Rock, Paper, Scissors!"
    puts "You chose: #{user.hand}"
    puts "The computer chose: #{computer.hand}"
    puts "------------------------------------"
	end

	def play_again?
    puts "Wanna play again? (y/n)"
    again = gets.chomp
    if again == "y"
    	start
    else
    	puts "Have a nice day!"
    end
	end
end	

game = RockPaperScissors.new
game.start



