# require '5desk.txt'

class Game
  attr_accessor :secret_word, :guesses_remaining, :secret_word_display, :guessed_correct_letters, :guessed_incorrect_letters

  def initialize
    @dictionary = File.read "5desk.txt"
    @dictionary = @dictionary.split(" ")
    @guesses_remaining = 7
    @guessed_correct_letters = []
    @guessed_incorrect_letters = []

    set_secret_word
    set_secret_word_display
  end
  
  def set_secret_word
    @secret_word = @dictionary.sample
    while @secret_word.length < 5 || @secret_word.length > 12
      @secret_word = @dictionary.sample
    end
  end
  
  def set_secret_word_display
    @secret_word_display = []
    @secret_word.length.times do
      @secret_word_display.push("_")
    end

    @secret_word_display = @secret_word_display.join(" ")
  end

  def user_intro
    puts "Hi there! Welcome to Hangman"
  end

  def display_guessed_letters
    puts @guesses_remaining
    puts @guessed_correct_letters
    puts @guessed_incorrect_letters
  end

  def get_user_guess
    puts "What letter would you like to choose?"
    user_guess = gets.chomp
    unless valid_guess?(user_guess)
      puts "Please enter a valid letter"
      get_user_guess
    end
  end

  def valid_guess?(user_guess)
    /[a-z]/.match?(user_guess.downcase) && user_guess.length == 1
  end
end


game1 = Game.new

# puts game1.get_user_guess