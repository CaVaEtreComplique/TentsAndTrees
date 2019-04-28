# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: UiManager.rb
# @Last modified by:   Sckylle
# @Last modified time: 24-Apr-2019

##
# ===== 404
# This class was not commented in the first place, so it can not be documented.
class UiManager
   # :nodoc:
    attr_reader :win,:loadScreen,:mainScreen,:levelNumberScreen,:modeScreen,:listeSaveScreen,:paramScreen,:diffchScreen, :gameScreen, :session, :highScoresScreen,:rulesScreen, :ic

  def initialize(window,player)
    ProcessStatus.new
    @player=player
    @win=window
    @ic=IconAsset.new
    update
  end

  def update
    @mainScreen=PrincipalScreen.new(self)
    @modeScreen=GameModeScreen.new(self)
    @highScoresScreen=HighScoresScreen.new(self)
    @paramScreen=ParametreScreen.new(self)
    @diffchScreen=ChoixDiffScreen.new(self)
    @loadScreen=LoadingScreen.new(self)
    @listeSaveScreen=SaveScreen.new(self,Connexion.getJoueur)
    @rulesScreen=RuleScreen.new(self,@ic)
  end

  def updateSave
    @listeSaveScreen=SaveScreen.new(self,Connexion.getJoueur)
  end
   def updateHighScore
    @highScoresScreen=HighScoresScreen.new(self)
  end

  def run
    @mainScreen.applyOn(@win)
  end

  def runGameSession(session,partOfAdventure=false)
    Thread.new {
      @loadScreen.applyOn(@win)
      @session=session unless partOfAdventure
      @loadScreen.run
      game=session.game
      # Generation des textures
      cellAssets=CellAssets.new(game.nRow, game.nCol)
      if session.gameMode != :tutorial
        # Generation des ecrans de jeu
        victoryScreen=getVictoryScreen(session)
        @gameScreen=GameScreen.new(self,game,cellAssets,victoryScreen)
        ProcessStatus.send("Affichage de l'écran de jeu")
        @gameScreen.applyOn(@win)
        ProcessStatus.send("Lancement de la partie")
      else
        # Generation des ecrans de jeu
        victoryScreen=getVictoryScreen(session)
        @gameScreen=TutorialGameScreen.new(self,game,cellAssets,victoryScreen)
        ProcessStatus.send("Affichage de l'écran de jeu")
        @gameScreen.applyOn(@win)
        ProcessStatus.send("Lancement de la partie")
      end
      game.run
    }
  end

  def runAdventureSession(session)
    @session=session
    @levelNumberScreen=LevelSelectionScreen.new(self,@ic)
    @levelNumberScreen.applyOn(@win)
  end

  def getVictoryScreen(session)
    if session.partOfAdventure?
      AdventureVictoryScreen.new(self,session)
    elsif session.isTutorial?
      TutorialVictoryScreen.new(self,@session)
    else
      VictoryScreen.new(self,@session)
    end
  end

  def runGameSessionFromSave(save)
    @session = save.content_save
    @session.setSave(save.id_save)
    case session.gameMode
    when :adventure
      runAdventureSession(@session)
    else
      runGameSession(@session)
    end
  end

  def createNewSave
    @session.save
  end

end
