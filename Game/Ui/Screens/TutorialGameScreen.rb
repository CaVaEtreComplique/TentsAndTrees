# @Author: Maxime Touze <maxime>
# @Date:   05-Apr-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: TutorialUI.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019




require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../GridUi"
require File.dirname(__FILE__) + "/../HelpUi"
require File.dirname(__FILE__) + "/../Buttons/Button"

class TutorialGameScreen < Screen

  attr_reader :gridUi

  attr_writer :helpDisplayed

  def initialize(manager,game,cellAssets,victoryScreen)
    super(manager.win)
    (@game=game).add_observer(self)
    @victoryScreen = victoryScreen
    @pauseScreen = PauseScreen.new(self,manager,@game)

    @gridUi=GridUi.new(game, cellAssets,self)
    @gtkObject = Gtk::Table.new(4,4)

    screen=Gdk::Screen.default

    buttonHeight = screen.height*0.04
    buttonWidth = screen.width*0.3

    @helpResponseUi = Text.new ""
    @helpResponseUi.style="italic"
    @helpResponseUi.weight="normal"
    @helpResponseUi.color="red"
    @helpResponseUi.size=15

    aliPause=Gtk::Alignment.new(1, 0.2, 0, 0).add(pause.gtkObject)

    globalAli=Gtk::Alignment.new(1, 1, 0, 1).add(globalBox)

    @gtkObject.attach(globalAli,3,4,0,1)
    @gtkObject.attach(@helpResponseUi.gtkObject,3,4,2,3)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,4)
    @gtkObject.attach(@gridUi.gtkObject, 0, 1, 0, 3)
  end

  def gridAltered
    if helpDisplayed?
      @helpResponseUi.updateLabel ""
      @helpCR[1]
      #  Make the concerned cells normal
      @helpCR[1].each{ |cell|
        cellUi= gridUi.cells[cell.row][cell.column]
        cellUi.normal
      }
      helpDisplayed=false
    end
  end

  def helpDisplayed?
    @helpDisplayed
  end

  def update
    if !@parent.active?
      @pauseScreen.applyOn(@parent)
    end
    if @game.currentGuess.grid==@game.correction
      @victoryScreen.applyOn(@parent,@game.calculateScore,true)
      @game.delete_observers
    end
  end

end
