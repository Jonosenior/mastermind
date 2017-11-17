class ComputerGuesser
  attr_reader :guess, :guesses_made, :correct_digits

  def initialize
    reset_guess
    @correct_digits = []
    @guesses_made = 0
    @possible_digits = (1..8).to_a
  end

  def make_a_guess
    @current_guess = @possible_digits[@guesses_made]
    if @correct_digits.length != 4
      4.times {@guess.push(@current_guess)}
    else
      @guess = @correct_digits
      @correct_digits.shuffle!
    end
    @guess
  end

  def remember_correct_digits(feedback)
    if feedback.include?(1) || feedback.include?(2)
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
