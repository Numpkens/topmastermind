class Mastermind
  def initialize
    @colors = [1, 2, 3, 4, 5, 6]
    @code_length = 4
    @max_turns = 12
  end

  def create_code
    Array.new(@code_length) { @colors.sample }
  end

  def check_guess(guess, code)
    exact_matches = 0
    color_matches = 0

    # Check exact matches
    guess.each_with_index do |color, index|
      if color == code[index]
        exact_matches += 1
      end
    end

    # Check color matches
    guess_tally = guess.tally
    code_tally = code.tally  # Fixed: was using + instead of =

    @colors.each do |color|
      color_matches += [guess_tally[color].to_i, code_tally[color].to_i].min
    end

    color_matches -= exact_matches

    [exact_matches, color_matches]  # Fixed: return both values in array
  end

  def valid_guess?(guess)
    return false unless guess.length == @code_length
    guess.all? { |num| @colors.include?(num) }
  end

  def play
    puts "Welcome to Mastermind!"
    puts "Try to guess the 4-digit code (numbers 1-6)"

    secret_code = create_code
    attempts_left = @max_turns

    while attempts_left > 0
      print "Enter your guess (4 digits, 1-6, separated by spaces): "
      guess = gets.chomp.split.map(&:to_i)

      unless valid_guess?(guess)  # Added input validation
        puts "Invalid guess! Please enter #{@code_length} numbers between 1 and 6"
        next
      end

      if guess == secret_code
        puts "Congratulations! You've cracked the code!"
        return
      end

      # Added feedback output
      exact, color = check_guess(guess, secret_code)
      puts "Exact matches: #{exact}, Color matches: #{color}"

      attempts_left -= 1
      puts "Attempts remaining: #{attempts_left}"
    end

    puts "Game Over! The code was #{secret_code}"
  end
end

game = Mastermind.new
game.play
