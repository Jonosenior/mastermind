class ComputerGuesser
  attr_reader :guess, :guesses_made, :correct_digits, :possible_answers

  def initialize
    reset_guess
    @correct_digits = []
    @guesses_made = 0
    @possible_digits = (1..6).to_a.shuffle
    #@previous_guesses = []
    @correct_digits_permutated = false
    @possible_answers = (1..6).to_a.repeated_permutation(4).to_a
  end

  # The AI's strategy is first to find the correct digits irrespective of position, and then to order them corretly.
  # The first guesses all repeat one digit (eg 1111).
  # Once the four correct digits are discovered, the AI makes a possible_answers array with all 24 possible permutations of those 4 digits.
  # From then on, each guess picks randomly from that array.
  # The AI then uses the feedback on these guesses to narrow down range of possible answers - removing possible answers that are now impossible given the feedback.

  def make_a_guess
    @guess = @possible_answers.sample
  end

  def evaluate_feedback(feedback)
    @feedback = feedback
    puts "Num Poss answers: #{@possible_answers.length}"
    #puts "Poss Answers: #{@possible_answers}"
    actual_number_of_perfectly_matched_digits = @feedback.count(2)
    actual_number_of_incorrect_digits = @feedback.count(0)
    update_possible_answers_greens(actual_number_of_perfectly_matched_digits)
    #update_possible_answers_whites(actual_number_of_incorrect_digits)
  end


  def update_possible_answers_whites(actual_number_of_incorrect_digits)
    answerscopy = @possible_answers.dup
      answerscopy.each do |sub_arr|
        case actual_number_of_incorrect_digits
        when 4
          @guess.each { |digit| if sub_arr.include?(digit) then @possible_answers.delete(sub_arr) end }
        when 0
          @guess.each { |digit| if !(sub_arr.include?(digit)) then @possible_answers.delete(sub_arr) end }
        end
      end
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
    #puts @possible_answers.length
  end

  def iterate_guesses_made
    @guesses_made = @guesses_made + 1
  end

  def reset_guess
    @guess = []
  end


end
