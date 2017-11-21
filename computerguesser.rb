class ComputerGuesser
  attr_reader :guess, :guesses_made, :correct_digits

  def initialize
    reset_guess
    @correct_digits = []
    @guesses_made = 0
    @possible_digits = (1..6).to_a.shuffle
    #@previous_guesses = []
    @correct_digits_permutated = false
  end

  # The AI's strategy is first to find the correct digits irrespective of position, and then to order them corretly.
  # The first guesses all repeat one digit (eg 1111).
  # Once the four correct digits are discovered, the AI makes a possible_answers array with all 24 possible permutations of those 4 digits.
  # From then on, each guess picks randomly from that array.
  # The AI then uses the feedback on these guesses to narrow down range of possible answers - removing possible answers that are now impossible given the feedback.


  def make_a_guess
    if @correct_digits.length > 3
      make_an_educated_guess
    else
      @current_guess = @possible_digits[@guesses_made]
      4.times {@guess.push(@current_guess)}
      #@previous_guesses << @guess
      @guess
    end
  end

  def make_an_educated_guess
    if !@correct_digits_permutated then permutate_correct_digits end
    @guess = @possible_answers.sample
  end

  def evaluate_feedback(feedback)
    @feedback = feedback
    (@correct_digits.length < 4) ? remember_correct_digits : update_possible_answers
  end

  def update_possible_answers
    actual_number_of_perfectly_matched_digits = @feedback.count(2)
    remove_impossibles_from_possible_answers(actual_number_of_perfectly_matched_digits)
  end

  def remove_impossibles_from_possible_answers(actual_number_of_perfectly_matched_digits)
    @possible_answers.each do |sub_arr|
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

  def permutate_correct_digits
    @possible_answers = @correct_digits.permutation.to_a
    @correct_digits_permutated = true
  end

  def remember_correct_digits
    if (@feedback.include?(1) || @feedback.include?(2))
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
