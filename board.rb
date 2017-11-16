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
    @board_history.reverse_each do |sub_array|
      print "Guess number: #{sub_array[0]} Guess: #{sub_array[1]} Feedback: #{sub_array[2]}\n\n"
    end
  end

  def create_board_history
    @board_history = []
    for element in 1..@max_guesses_allowed
      @board_history.push([element, "_________________", "________"])
    end
  end

  def update_board_history_user_guess(current_guess)
    @board_history[guesses_made][1] = current_guess
  end

  def update_board_history_feedback(feedback)
    @board_history[guesses_made][2] = feedback
  end

  def iterate_guesses_made
    @guesses_made +=1
  end

end
