class FeedbackCreator
  attr_reader :feedback

  def initialize(solution)
    @feedback = []
    @solution = solution
  end

  def return_feedback(guess)
    solution = @solution.dup
    guess = guess.dup
    guess.each_with_index do |element, index|
      if element == solution[index]
        @feedback.push(2)
        solution[index] = "matched"
        guess[index] = "also_matched"
      end
    end

    guess.each do |element|
      if element.class == Fixnum && solution.include?(element)
        @feedback.push(1)
        solution[solution.index(element)] = "matched"
      elsif element.class == Fixnum
        @feedback.push(0)
      end
    end

  @feedback.sort!.reverse!
  end

  def reset
    @feedback = []
  end
end
