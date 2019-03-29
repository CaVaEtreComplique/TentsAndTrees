# @Author: Corentin Petit <CorentinPetit>
# @Date:   10-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: VictoryScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 28-Mar-2019


require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class VictoryScreen < Screen

  def initialize(manager,session)
    @manager=manager
    super(@manager.win)
    screen = Gdk::Screen.default
    @gtkObject=Gtk::Table.new(3,3)
    vBox=Gtk::Box.new(:vertical)
    @session=session

    @scoreText=Text.new(@textManager.getScreenTexts("victory" , "errscore"))
    @resultText=Text.new(@textManager.getScreenTexts("victory" , "win"))
    @resultText.title
    vBox.pack_start(@resultText.gtkObject, expand: false, fill: true, padding: 50)
    vBox.pack_start(@scoreText.gtkObject, expand: false, fill: true, padding: 40)

    @replay=Text.new(@textManager.getButtonLabel("victory" , "retry"))
    vBox.pack_start(@replay.gtkObject, expand: false, fill: true, padding: 20)

    quit=Text.new(@textManager.getButtonLabel("victory" , "quit"))
    quit.onClick{
      @manager.mainScreen.applyOn(@parent)
    }
    vBox.pack_start(quit.gtkObject, expand: false, fill: true, padding:20)


    Gtk::Alignment.new(0.5, 0.2, 0, 0)
    @gtkObject.attach(vBox,0,3,0,1)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end

  def applyOn(widget,sScore,isWon)
    screen = Gdk::Screen.default
    @score=sScore
    newlab=@textManager.getScreenTexts("victory" , "score")+" "+@score.to_s
    @scoreText.updateLabel(newlab)
    if !isWon
      @resultText.updateLabel(@textManager.getScreenTexts("victory" , "lose"))
      @resultText.title
    end
    if !isWon || !@session.continuable?
      if @session.partOfAdventure?
        @replay.updateLabel(@textManager.getButtonLabel("victory" , "levelselection"))
        @replay.onClick{
          @manager.modeScreen.applyOn(@parent)
        }
      else
        @replay.updateLabel(@textManager.getButtonLabel("victory" , "retry"))
        @replay.onClick{
          @session.replay(false)
          @manager.runGameSession(@session)
        }
      end
    else
      if @session.partOfAdventure? && @session.gameMode == :timeAttack && @session.finishedGrid == @session.numberOfGrid
        #Afficher les etoiles à implementer
        @replay.updateLabel(@textManager.getButtonLabel("victory" , "levelselection"))
        @replay.onClick{
          @manager.levelNumberScreen.applyOn(@parent)
        }
      else
        @replay.onClick{
          @session.replay(true)
          @manager.runGameSession(@session)
        }
      end
    end
    super(widget)
  end

end
