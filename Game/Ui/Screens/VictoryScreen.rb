# @Author: Corentin Petit <CorentinPetit>
# @Date:   10-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: VictoryScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 29-Mar-2019


require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class VictoryScreen < Screen

  def initialize(manager,session)
    @manager=manager
    super(@manager.win)
    screen = Constants::SCREEN
   @pad=Constants::BUTTON_PADDING
    @gtkObject=Gtk::Table.new(3,3)
    vBox=Gtk::Box.new(:vertical)
    @session=session

    @scoreText=Text.new(@textManager.getScreenTexts("victory" , "errscore"))
    @resultText=Text.new(@textManager.getScreenTexts("victory" , "win"))
    @resultText.title
    vBox.pack_start(@resultText.gtkObject, expand: false, fill: true, padding:@pad)
    vBox.pack_start(@scoreText.gtkObject, expand: false, fill: true, padding: @pad)

    @replay=Text.new(@textManager.getButtonLabel("victory" , "retry"))
    vBox.pack_start(@replay.gtkObject, expand: false, fill: true, padding: @pad)

    quit=Text.new(@textManager.getButtonLabel("victory" , "quit"))
    quit.onClick{
	    @manager.updateHighScore
      @manager.updateSave
      @manager.mainScreen.applyOn(@parent)
    }
    vBox.pack_start(quit.gtkObject, expand: false, fill: true, padding:@pad)


    Gtk::Alignment.new(0.5, 0.2, 0, 0)
    @gtkObject.attach(vBox,0,3,0,1)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end

  def applyOn(widget,sScore,isWon, associatedTimer =0)
    screen = Gdk::Screen.default
    @score=sScore.truncate

    j=Connexion.getJoueur()
    db = ConnectDB.new()
    ["TERM", "INT", "QUIT"].each{ |sig|
      Signal.trap(sig) { Gtk.main_quit }
    }
    hg = db.getPlayerHighScoreByGamemodeDiff(@session.gameMode, @session.difficulty, j)
    if(hg == nil)
        db.addHighScore(@session.gameMode, @session.difficulty, j, @score)
    else
      if(@score > hg.score_highScores)
        db.updateHighScore(@session.gameMode, @session.difficulty, j, @score)
      end
    end
    newlab=@textManager.getScreenTexts("victory" , "score")+" "+@score.to_s
    @scoreText.updateLabel(newlab)
    if !isWon
      @resultText.updateLabel(@textManager.getScreenTexts("victory" , "lose"))
      @resultText.title
    end
    if !isWon || !@session.continuable?
        @replay.updateLabel(@textManager.getButtonLabel("victory" , "retry"))
        @replay.onClick{
          @session.replay(false)
          @manager.runGameSession(@session)
        }
    else
        @replay.updateLabel(@textManager.getButtonLabel("victory" , "continue"))
        @replay.onClick{
          @session.replay(true)
          @manager.runGameSession(@session)
        }
    end
    super(widget)
  end

end
