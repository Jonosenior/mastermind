class FeedbackCreator
  attr_reader :feedback

  def initialize(solution)
    @feedback = []
    @solution = solution
  end

  def return_feedback(guess)
    solution = @solution.dup
    #puts "#{solution}"
    guess.each_with_index do |element, index|
      if element == solution[index]
        @feedback.push(2)
        solution[index] = "Done" 
      elsif solution.include?(element)
        @feedback.push(1)
        solution[solution.index(element)] = "Done"
      else
        @feedback.push(0)
        #secret_code[secret_code.index(element)] = "Done"
      end
    end
  # print "Secret_code: #{solution}\n"
  # print "Feedback: #{feedback}\n"
  @feedback.sort!.reverse!
  end

  def reset
    @feedback = []
  end
end

# def return_feedback(guess, secret_code)
#
#   # First, search for matching value AND position.
#   puts "Guess: #{guess}"
#   puts "Secret Code: #{secret_code}"
#
#   remaining_guess_items = []
#   remaining_secret_items = []
#
#   for i in 0..secret_code.length-1
#     if guess[i] == secret_code[i]
#       @feedback.push("Y")
#     else
#       remaining_guess_items.push(guess[i])
#       remaining_secret_items.push(secret_code[i])
#     end
#   end
#   # Second, search for just matching value
#   remaining_guess_items.each_with_index do |guess_element, guess_index|
#     if (remaining_secret_items.include?(guess_element))
#       @feedback.push("y")
#       #Need to remove the first matching element from secret code here?
#     else
#       @feedback.push("n")
#     end
#   end
#
#   puts "#{@feedback}"
#
#   @feedback
# end
