# require '5desk.txt'

class Game
  attr_accessor :secret_word, :guesses_remaining, :hanged_secret_word, :guessed_correct_letters, :guessed_incorrect_letters, :current_letter_guess

  def initialize
    @dictionary = File.read "5desk.txt"
    @dictionary = @dictionary.split(" ")
    @guesses_remaining = 7
    @guessed_correct_letters = []
    @guessed_incorrect_letters = []

    set_secret_word
    set_hanged_secret_word

  end
  
  def set_secret_word
    @secret_word = @dictionary.sample.downcase.split
    while @secret_word.length < 5 || @secret_word.length > 12
      @secret_word = @dictionary.sample.downcase.split
    end
  end
  
  def set_hanged_secret_word
    @hanged_secret_word = []
    @secret_word.length.times do
      @hanged_secret_word.push("_")
    end
    @hanged_secret_word = @hanged_secret_word.join(" ")
  end

  def user_intro
    puts "Hi there! Welcome to Hangman"
  end

  def display_user_feedback
    puts "Number of Guesses Remaining: #{@guesses_remaining}"
    puts "Correct Letters Guessed: #{@guessed_correct_letters.join(" ")}"
    puts "Incorrect Letters Guessed: #{@guessed_incorrect_letters.join(" ")}"
    puts "\n#{@hanged_secret_word}\n"
  end

  def get_user_guess
    puts "What letter would you like to choose?"
    temp_guess = gets.chomp
    if valid_guess?(temp_guess)
      @current_letter_guess = temp_guess.downcase
    else
      puts "Please enter a valid letter"
      get_user_guess
    end
  end

  def valid_guess?(user_guess)
    repeat = repeated_letter?(user_guess)
    /[a-z]/.match?(user_guess.downcase) && user_guess.length == 1 && !repeat
  end

  def repeated_letter?(letter)
    @guessed_correct_letters.include?(letter) || @guessed_incorrect_letters.include?(letter)
  end

  def process_guess
    count = 0
    @secret_word.each_with_index do |element, index|
      if @current_letter_guess == element
        @hanged_secret_word[index] = @current_letter_guess
        count += 1
      end
    end

    if count == 0
      @guessed_incorrect_letters.push(@current_letter_guess)
      @guesses_remaining -= 1
    else
      @guessed_correct_letters.push(@current_letter_guess)
    end
  end

  def display_hanged_secret_word
    puts "HERES WHERE WE TURN AN ARRAY INTO A STRING"
  end

  def game_over?
    if game_loss?
      puts "GAME WAS LOST"
    elsif game_won?
      puts "GAME WON"
    end

    game_loss? || game_won?
  end

  def game_loss?
    @guesses_remaining == 0
  end

  def game_won?
    !@hanged_secret_word.include?("_")
  end

  def play_game
    user_intro
    puts @secret_word
    until game_over?
      get_user_guess
      process_guess
      display_user_feedback

    end
  end
end


game1 = Game.new
game1.play_game





