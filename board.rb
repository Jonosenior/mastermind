class Board

  attr_reader :max_guesses_allowed, :board_history
  attr_accessor :guesses_made

  def initialize
    # @guess_number is the eg first, second, third etc guess made
    @guesses_made = 0
    # @max_guesses_allowed is the total number of guesses a player has
    @max_guesses_allowed = 12
    # @board_history is a 2D array which stores: guess_number, player_guess, feedback
    create_board_history
  end

  def display_board
    i = 0
    print "\n\n    ________________________\n"
    print "   |            |           |\n"

    12.times do
      represent_guess = @board_history[i][0].join("")
      represent_feedback = @board_history[i][1].join("")
      print "   |    #{represent_guess}    |    #{represent_feedback}   |\n"
      i+=1
    end
    print "   |____________|___________|\n\n"

  end

  def create_board_history
    @board_history = []
    for element in 1..@max_guesses_allowed
      @board_history.push([[0,0,0,0], ["·","·","·","·"]])
   end
   @board_history
  end


  def update_board_history(guess, feedback)
    puts "Update board history, guesses made: #{@guesses_made}"
    @board_history[@guesses_made][0] = guess
    @board_history[@guesses_made][1] = feedback
    @guesses_made += 1
  end

end
