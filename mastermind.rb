# the main class, which calls the Mastermind and allows user to select a role
class Game
  def initialize
    @master = Mastermind.new
    play
  end

  private
  # player plays playfully here
  def play
    take_turn until @master.game_over?
  end

  # one need to take turns
  def take_turn
    puts @master.show_board
    puts "\nPick your colors (one by one):"
    puts @master.show_colors.join(", ")

    input = []
    until input.length == 4
      pick = gets.chomp.downcase
      if input_validation(pick)
        input << pick
      else
        puts "Don't know that color, sorry."
      end
    end
    puts "You picked #{input.join(", ")}"
    @master.guess(input)
  end

  def input_validation(pick)
    true if @master.show_colors.include?(pick)
  end


end

# Mastermind class handles the mastermind thingy itself
class Mastermind
  # map of colors
  @@colors = ["red", "green", "blue", "yellow", "brown", "orange", "black", "white"]
  def initialize
    puts "Let's play Mastermind!"
    @code = code_generator
    @turns = 0
    @the_board = []
    @last_guess = []
  end

  def show_colors
    @@colors
  end

  def guess(input)
    @last_guess = input
    compare(input)
    @turns += 1
  end

  # need to dublicate input and code each time, and change checked values
  def compare(input)
    score = []
    user_guesses = input.dup
    code = @code.dup

    # have to use while loop for more control
    # checking for direct hits
    i = 0
    while i < user_guesses.length
      if user_guesses[i] == code[i]
        score << "+"
        user_guesses.delete_at(i)
        code.delete_at(i)
      else
        i += 1
      end
    end

    # checking for indirect hits
    i = 0
    while i < user_guesses.length
      if code.include?(user_guesses[i])
        score << "-"
        color = user_guesses[i]
        user_guesses.delete(color)
        code.delete(color)
      else
        i += 1
      end
    end

    until score.length == 4
      score << "o"
    end

    add_to_the_board(input, score)
  end

  def show_board
    @the_board.each do |c, s|
      print "\n " + c.join("\t")
      print "\t" + s.join(' ')
    end
    puts
  end

  def add_to_the_board(input, score)
    @the_board[@turns] = [input, score]
  end

  # checks if the game is over
  def game_over?
    (@turns == 12) || victory?
  end

  private
  # check if the player is victorious
  def victory?
    @code == @last_guess
  end

  # generates random code
  def code_generator
    code = []
    4.times do
      code << @@colors[rand(0..7)]
    end
    code
  end
end

# starting the game
Game.new
