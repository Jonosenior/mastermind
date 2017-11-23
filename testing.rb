require File.expand_path("../computerguesser", __FILE__)
require File.expand_path("../feedback", __FILE__)
require File.expand_path("../solution", __FILE__)

class Test

  def initialize
    @solution = SolutionCreator.new(true).create_solution
    @feedback_creator = FeedbackCreator.new(@solution)
    @computerguesser = ComputerGuesser.new
    #puts "#{@solution}"
  end

  def start_test
    while @computerguesser.guesses_made  < 12
      @guess = @computerguesser.make_a_guess
      #puts "No. Poss Answers: #{@computerguesser.possible_answers.length}"
      #puts "Guess #{@computerguesser.guesses_made}: #{@guess}"
      #puts @guess
      @feedback = @feedback_creator.return_feedback(@guess)
      return true if is_guess_correct?
      #puts "I shouldn't be read"
      computer_guesser_evaluates_feedback
      @feedback_creator.reset
    end
    return false
  end

  def computer_guesser_evaluates_feedback
    @computerguesser.evaluate_feedback(@feedback)
    @computerguesser.iterate_guesses_made
    @computerguesser.reset_guess
  end

  def is_guess_correct?
    @guess == @solution
  end


end

number_of_wins = 0
100000.times do
  test = Test.new
  if test.start_test then number_of_wins +=1 end
end
puts "#{number_of_wins.to_f / 100000}"
