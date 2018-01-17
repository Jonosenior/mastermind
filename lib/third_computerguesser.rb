class ComputerGuesser
  attr_reader :guess, :guesses_made, :correct_digits, :possible_answers

  def initialize
    reset_guess
    @guesses_made = 0
    @possible_answers = (1..6).to_a.repeated_permutation(4).to_a
  end

  def make_a_guess
    @guess = @possible_answers.sample
  end

  def evaluate_feedback(feedback)
    @feedback = feedback
    #puts "Num Poss answers: #{@possible_answers.length}"
    actual_number_of_perfectly_matched_digits = @feedback.count(2)
    update_possible_answers_greens(actual_number_of_perfectly_matched_digits)
  end

  def update_possible_answers_greens(actual_number_of_perfectly_matched_digits)
    answerscopy = @possible_answers.dup
    answerscopy.each do |sub_arr|
      theoretical_number_of_perfectly_matched_digits = 0
      for index in 0..3
        if sub_arr[index] == @guess[index]
          theoretical_number_of_perfectly_matched_digits +=1
        end
      end
      if actual_number_of_perfectly_matched_digits != theoretical_number_of_perfectly_matched_digits
        @possible_answers.delete(sub_arr)
      end
    end
    @possible_answers.delete(guess)
  end

  def iterate_guesses_made
    @guesses_made = @guesses_made + 1
  end

  def reset_guess
    @guess = []
  end


end
