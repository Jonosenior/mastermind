class Board

  attr_reader :max_guesses_allowed, :board_history
  attr_accessor :guesses_made

  def initialize
    @guesses_made = 0
    @max_guesses_allowed = 12
    create_board_history
  end

  def display_board
  i = 0
  print "    _____________________________\n"
  print "   |               |             |\n"

  12.times do
    represent_guess = @board_history[i][0].join(" ")
    represent_feedback = @board_history[i][1].join("")
    print "   |    #{represent_guess}    |  #{represent_feedback}   |\n"
    i+=1
  end
  print "   |_______________|_____________|\n\n"

end

  def convert_digit_to_colored_block(digit)
    return " ■".colorize(:green) if digit == 2
    return " ■".colorize(:red) if digit == 1
    return " ■".colorize(:white) if digit == 0
  end

  def create_board_history
    @board_history = []
    block = " ■".colorize(:blue)
    for element in 1..@max_guesses_allowed
      @board_history.push([[0,0,0,0], [block, block, block, block]])
   end
   @board_history
  end


  def update_board_history(guess, feedback)
    @board_history[@guesses_made][0] = guess
    @board_history[@guesses_made][1] = feedback.map {|x| convert_digit_to_colored_block(x)}
    @guesses_made += 1
  end

  def introduce_board
    puts "THE BOARD\n\n"
    puts "This is the game board:"
    display_board
    puts "There are two columns: left for the guess; right for the feedback."
    puts "Each row is a new turn.\n\n\n"
    puts "FEEDBACK\n\n"
    print "The Feedback column will show you four coloured blocks, like this:"
    print " ■".colorize(:green)
    print " ■".colorize(:red)
    print " ■".colorize(:red)
    print " ■\n\n".colorize(:white)
    puts "    - #{"BLUE".colorize(:blue)} is for unplayed turns."
    puts "    - #{"GREEN".colorize(:green)} means you have a correct digit in the correct position."
    puts "    - #{"RED".colorize(:red)} means you have a correct digit in the wrong position."
    puts "    - #{"WHITE".colorize(:white)} means a digit is wrong.\n\n\n"
  end

end
