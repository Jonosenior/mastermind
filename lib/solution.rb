class SolutionCreator

  attr_reader :solution

  def initialize(human_guesser)
    human_guesser ? @solution = create_solution : @solution = user_inputs_solution
  end

  def create_solution
    @solution = []
    loop do
      number = rand(1..6)
      @solution.push(number) unless @solution.include?(number)
      break if @solution.length == 4
    end
    @solution
  end

  def user_inputs_solution
    puts "ENTER SECRET CODE\n\n"
    puts "Now you have to choose your 4-digit secret solution.\n"
    puts "This is the code the computer will try and guess.\n"
    puts "Remember - it's four digits, no duplicates, and only the numbers 1-6.\n"
    @solution = gets.chomp.split('').map(&:to_i)
    while !(is_user_input_legitimate?(@solution))
      puts "That's not a legitimate code. Please try again."
      user_inputs_solution
    end
    @solution
  end

  def is_user_input_legitimate?(input)
    return false if !(input.all? {|element| element.class == Fixnum})
    return false if input.length != 4
    return false if !(input.all? {|element| (1..6).include?(element)})
    return false if input.uniq.length != input.length
    true
  end


end
