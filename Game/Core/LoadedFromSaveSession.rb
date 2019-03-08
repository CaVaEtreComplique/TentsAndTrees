# @Author: Corentin Petit <zeigon>
# @Date:   08-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: LoadedFromSaveSession.rb
# @Last modified by:   zeigon
# @Last modified time: 08-Mar-2019

require File.dirname(__FILE__) +  "/Session"

class LoadedFromSaveSession < Session

  def initialize(gameMoves, gameTime, gridPick, score, gameMode, difficulty)
    super(gameMode, difficulty)
    @time=time
    @score=score
    @gridPick=gridPick
    @game=game.new(self)
    @game.currentGuess=gameMoves
    @game.time=time
  end

end
