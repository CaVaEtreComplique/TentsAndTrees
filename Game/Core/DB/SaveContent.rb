
class SaveContent

  @guess
  @time
  @score
  @gridPick
  @gameMode
  @difficulty

  attr_reader :guess, :time, :score, :gridPick, :gameMode, :difficulty

  def initialize(guess, time, score, gridPick, gameMode, difficulty)
      @guess, @time, @score, @gridPick, @gameMode, @difficulty = guess, time, score, gridPick, gameMode, difficulty
  end

end
