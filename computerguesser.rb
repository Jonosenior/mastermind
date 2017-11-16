class ComputerGuesser
  attr_reader :guess

  def initialize
    reset_guess
  end

  def make_a_guess
    4.times {@guess.push(rand(1..8))}
    @guess
  end

  def reset_guess
    @guess = []
  end

end
