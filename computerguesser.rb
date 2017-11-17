class ComputerGuesser
  attr_reader :guess, :guesses_made, :correct_digits

  def initialize
    reset_guess
    @correct_digits = []
    @guesses_made = 0
    @possible_digits = (1..8).to_a #.shuffle! will randomise the guessing
  end

  def make_a_guess
    @current_guess = @possible_digits[@guesses_made]
  #  puts "correct digits length #{correct_digits.length}"
    if @correct_digits.length < 4
      4.times {@guess.push(@current_guess)}
    else
      @correct_digits.shuffle!
      @guess = @correct_digits
    end
    @guess
  end

  def remember_correct_digits(feedback)
    if (feedback.include?(1) || feedback.include?(2)) && (@correct_digits.length < 4)
      @correct_digits.push(@current_guess)
    end
  end

  def iterate_guesses_made
    @guesses_made = @guesses_made + 1
  end

  def reset_guess
    @guess = []
  end


end

  computer = ComputerGuesser.new
  computer.make_a_guess
