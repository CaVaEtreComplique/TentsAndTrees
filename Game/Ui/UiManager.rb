# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: UiManager.rb
# @Last modified by:   zeigon
# @Last modified time: 01-Mar-2019

class UiManager
    attr_reader :win

  def initialize(window)
    ProcessStatus.new
    @win=window
    @loadScreen=LoadingScreen.new(@win)
  end

  def runGameSession(session)
    Thread.new {
      @loadScreen.applyOn(@win)
      @loadScreen.run
      game=session.game
      # Generation des textures
      cellAssets=CellAssets.new(game.nRow, game.nCol)
      # Generation des ecrans de jeu
      victoryScreen=VictoryScreen.new(self,session)
      gameScreen=GameScreen.new(@win,game,cellAssets,victoryScreen)
      ProcessStatus.send("Affichage de l'écran de jeu")
      gameScreen.applyOn(@win)
      ProcessStatus.send("Lancement de la partie")
      game.run
      kill #It seems there is a bug where the trhread doesn't systematicaly kill itself at the end of the block
    }
  end

end
