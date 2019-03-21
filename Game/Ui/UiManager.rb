# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: UiManager.rb
# @Last modified by:   zeigon
# @Last modified time: 18-Mar-2019

class UiManager
    attr_reader :win,:loadScreen,:mainScreen,:levelNumberScreen,:modeScreen,:listeSaveScreen,:paramScreen,:diffchScreen, :gameScreen, :session

  def initialize(window,player)
    ProcessStatus.new
    @player=player
    @win=window
    update
  end

  def update
    @loadScreen=LoadingScreen.new(self)
    @mainScreen=FenetrePrinc.new(self)
    @modeScreen=ModeDeJeu.new(self)
    @paramScreen=Parametre.new(self)
    @diffchScreen=ChoixDiff.new(self)
    @listeSaveScreen=ListeSave.new(self,Connexion.getJoueur)
    @levelNumberScreen=LevelNumber.new(self)
  end

  def run
    @mainScreen.applyOn(@win)
  end

  def runGameSession(session)
    Thread.new {
      @loadScreen.applyOn(@win)
      @session=session
      @loadScreen.run
      game=@session.game
      # Generation des textures
      cellAssets=CellAssets.new(game.nRow, game.nCol)
      # Generation des ecrans de jeu
      victoryScreen=VictoryScreen.new(self,@session)
      @gameScreen=GameScreen.new(self,game,cellAssets,victoryScreen)
      ProcessStatus.send("Affichage de l'écran de jeu")
      @gameScreen.applyOn(@win)
      ProcessStatus.send("Lancement de la partie")
      game.run
    }
  end

  def createNewSave
    @session.save
  end

end
