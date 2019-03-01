# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: UiManager.rb
# @Last modified by:   zeigon
# @Last modified time: 01-Mar-2019

class UiManager

  def initialize(window)
    ProcessStatus.new
    @win=window
    (loadScreen=LoadingScreen.new(@win)).applyOn(@win)
    loadScreen.run
  end

  def runGameSession(session)
    game=session.game

    # Generation des textures
    cellAssets=CellAssets.new(game.nRow, game.nCol)
    # Generation des ecrans de jeu
    victoryScreen=VictoryScreen.new(@win,session)
    gameScreen=GameScreen.new(@win,game,cellAssets,victoryScreen)
    ProcessStatus.send("Affichage de l'écran de jeu")
    gameScreen.applyOn(@win)
    ProcessStatus.send("Lancement de la partie")
    game.run
  end

end
