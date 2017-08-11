# Need to build the Game class that handles the game itself, and calls to Mastermind class

# the main class, which calls the Mastermind and allows user to select a role
class Game
  def initialize
    p "initializing the game"
    @game = Mastermind.new
    play
  end

  #private
  # player plays playfully here
  def play
    p "The play is called"
    take_turn until @game.game_over?
  end

  # one need to take turns
  def take_turn
    p "Hello from take turn!"
    @game.guess
  end


end

# Mastermind class handles the mastermind thingy itself
class Mastermind

  def initialize
    p "initializing mastermind"
    @code = [1, 1, 3, 4]
    @turns = 3 # 12
    p @code, @turns
  end

  def guess
    p "Ahoy from M.guess"
    @turns -= 1
  end

  # checks if the game is over
  def game_over?
    p "we're in the M.game_over?"
    true if @turns == 0
  end

  # check if the player is victorious
  def victory?

  end
end

# starting the game
Game.new
