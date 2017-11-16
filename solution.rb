class SolutionCreator

  attr_reader :solution

  def initialize(setter_or_guesser)
    if setter_or_guesser == "human_guesser"
      @solution = create_solution
    elsif setter_or_guesser == "human_setter"
      @solution = user_inputs_solution
    end
  end

  def create_solution
    solution = []
    4.times {solution.push(rand(1..8))}
    solution
  end

  def user_inputs_solution
    puts "Now you have to choose your 4 digit secret solution.\n"
    puts "This is the code the computer will try and guess.\n"
    puts "Remember - it's four digits, and only the numbers 1-8.\n"
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
    return false if !(input.all? {|element| (1..8).include?(element)})
    true
  end

end
