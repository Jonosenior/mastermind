class Game
  def initialize
    @board = Board.new
    introduce_game
    user_chooses_player_type
    @solution_creator = SolutionCreator.new(@human_guesser)
    @solution = @solution_creator.solution
    @feedback_creator = FeedbackCreator.new
    start_game
  end

  def start_game
    while @board.guesses_made < @board.max_guesses_allowed
      @board.display_board
      puts "\n\n"
      @human_guesser ? new_human_guess : new_computer_guess
      retrieve_feedback
      if is_guess_correct? then win end
      @board.update_board_history(@guess, @feedback)
      puts "Solution: #{@solution}"
      puts "Guess: #{@guess}"
      puts "Feedback: #{@feedback}"
      puts "Computerguesser's guesses made: #{@computerguesser.guesses_made}"
      if !@human_guesser then computer_guesser_evaluates_feedback end
      @feedback_creator.reset
    end
    lose
  end

  def computer_guesser_evaluates_feedback
    @computerguesser.remember_correct_digits(@feedback)
    puts "Correct Digits: #{@computerguesser.correct_digits}"
    @computerguesser.iterate_guesses_made
    @computerguesser.reset_guess
  end

  def play_again
    puts "Do you want to play again? (y/n)"
    answer = gets.chomp.upcase
    case answer
    when "Y"
      puts "OK, Let's do it!"
      game = Game.new
    when "N"
      puts "No worries, see you soon!"
      exit
    else
      puts "I don't understand! Try again...\n"
      play_again
    end
  end

  def lose
    if @human_guesser
      puts "Oh no! You're out of turns"
      puts "The secret code was #{@solution}"
    else
      puts "Well done! Your secret code was too difficult for the computer!\n\n"
    end
    play_again
  end

  def win
    if @human_guesser
      puts "Congratulations! You got the correct code."
    else
      puts "Oh no! The computer guessed your code!\n\n"
    end
    play_again
  end

  def is_guess_correct?
    @guess == @solution
  end

  def retrieve_feedback
    @feedback = @feedback_creator.return_feedback(@guess, @solution_creator.solution)
  end

  def new_human_guess
    puts "OK, now you have to make a guess."
    puts "Remember: four digits, 1-8, no duplicates.\n"
    @guess = gets.chomp
    if !is_user_input_legitimate?(@guess)
      puts "Hey! Make a proper guess!"
      new_human_guess
    end
  end

  def new_computer_guess
    puts "The computer is thinking."
    @guess = @computerguesser.make_a_guess
  end

  def is_user_input_legitimate?(input)
    return false if !(input.all? {|element| element.class == Fixnum})
    return false if input.length != 4
    return false if !(input.all? {|element| (1..8).include?(element)})
    return false if input.uniq.length != input.length
    true
  end

  def introduce_game
    puts "MASTERMIND"
    puts "Welcome to Mastermind.\n\n\n"
    puts "THE RULES\n"
    puts "There are two players: You and the Computer."
    puts "One player chooses a 4-digit code."
    puts "The other player has 12 turns to guess what it is."
    puts "You have a choice. Choose:"
    puts "1: You set the code and the computer guesses"
    puts "2: The computer creates a code and you guess"
  end

  def user_chooses_player_type
    puts "Please enter 1 or 2.\n"
    answer = gets.chomp.to_i
    case answer
    when 1
      @human_guesser = false
      @computerguesser = ComputerGuesser.new
      puts "\n\n\n"
    when 2
      @human_guesser = true
      puts "\n\n\n"
    else
      puts "Come on, make a real choice!"
      user_chooses_player_type
    end
  end

end
