# @Author: Corentin Petit <CorentinPetit>
# @Date:   08-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: GameScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 26-Apr-2019



require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../GridUi"
require File.dirname(__FILE__) + "/../HelpUi"
require File.dirname(__FILE__) + "/../Buttons/Button"

##
# ===== 404
# This class was not commented in the first place, so it can not be documented.
class GameScreen < Screen
   # :nodoc:

  attr_reader :gridUi

  attr_writer :helpDisplayed

  def initialize(manager,game,cellAssets,victoryScreen)
    super(manager.win)
    @pad=Constants::BUTTON_PADDING
    (@game=game).add_observer(self)
    @victoryScreen = victoryScreen
    @pauseScreen = PauseScreen.new(self,manager,@game)

    @gridUi=GridUi.new(game, cellAssets,self)
    @gtkObject = Gtk::Table.new(4,4)

    screen=Gdk::Screen.default

    buttonHeight = screen.height*0.04
    buttonWidth = screen.width*0.3

    ProcessStatus.send(@textManager.getLoadingMessages("textures"))
    newGuess=Text.new(@textManager.getButtonLabel("ingame" , "newguess"))
    newGuess.onClick(){
      game.beginGuess
      @gridUi.refresh
    }
    removeGuess=Text.new(@textManager.getButtonLabel("ingame" , "refuteguess"))
    removeGuess.onClick(){
      game.removeGuess
      @gridUi.refresh
    }
    resetGrid=Text.new(@textManager.getButtonLabel("ingame" , "rz"))
    resetGrid.onClick(){
      game.resetGrid
      @gridUi.refresh
    }


    undoButton=Text.new(@textManager.getButtonLabel("ingame" , "undo"))
    undoButton.onClick(){
      @gridUi.undo
    }

    redoButton=Text.new(@textManager.getButtonLabel("ingame" , "redo"))
    redoButton.onClick(){
      @gridUi.redo
    }

    @helpResponseUi = Text.new ""
    @helpResponseUi.style="italic"
    @helpResponseUi.weight="normal"
    @helpResponseUi.color="red"
    @helpResponseUi.size=15
    @helpResponseUi.apply
    @helpResponseUi.setWrap(true)
    @helpResponseUi.setBackground(1,1,1,0.5)
    help=Text.new(@textManager.getButtonLabel("ingame" , "help"))
    help.onClick(){
      # Display the help message
      @helpCR=@game.help
      @helpResponseUi.updateLabel(@helpCR[0])
      self.helpDisplayed=true
      #  Make the concerned cells golw
      @helpCR[1].each{ |cell|
        cellUi= gridUi.cells[cell.row][cell.column]
        cellUi.glowing
      }
    }

    # pause=Text.new(@textManager.getButtonLabel("ingame" , "pause"))
    pause=Text.new(@textManager.getButtonLabel("ingame" , "pause"))
    pause.weight="ultrabold"
    pause.size=40
    pause.apply
      pause.onClick(){
        @game.chrono.stop
        @pauseScreen.applyOn(@parent)
    }

    @chronoUi=ChronoUi.new(@game.time.truncate)

    undoRedoBox = Gtk::Box.new(:horizontal)
    undoRedoBox.pack_start(undoButton.gtkObject, expand: true, fill: false, padding: 3)
    undoRedoBox.pack_start(redoButton.gtkObject, expand: true, fill: false, padding: 3)
    aliURB=Gtk::Alignment.new(0.5, 0.2, 0, 0).add(undoRedoBox)
    aliPause=Gtk::Alignment.new(1, 0.2, 0, 0).add(pause.gtkObject)

    globalBox = Gtk::Box.new(:vertical)
    globalBox.width_request=(screen.width*0.3)
    globalBox.pack_start(aliPause, expand: true, fill: true, padding: 3)
    globalBox.pack_start(@chronoUi.gtkObject, expand: true, fill: false, padding: 10)
    globalBox.pack_start(aliURB, expand: true, fill: false, padding: 3)
    globalBox.pack_start(resetGrid.gtkObject, expand: true, fill: false, padding: 3)
    globalBox.pack_start(newGuess.gtkObject, expand: true, fill: false, padding: 3)
    globalBox.pack_start(removeGuess.gtkObject, expand: true, fill: false, padding: 3)
    globalBox.pack_start(help.gtkObject, expand: true, fill: false, padding: 10)
    # globalBox.pack_start(@helpResponseUi.gtkObject, expand: false, fill: false, padding: 10)

    globalBoxH = Gtk::Box.new(:horizontal).add(globalBox)
    globalAli  = Gtk::Alignment.new(0.5, 0, 0, 0).add(globalBoxH)
    helpCRAli  = Gtk::Alignment.new(0.5, 0, 0, 1 ).add(@helpResponseUi.gtkObject)

    @gtkObject.attach(globalAli,3,4,1,2)
    @gtkObject.attach(helpCRAli,2,4,2,3)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer2),0,4,0,4)
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
      @game.chrono.stop
      @pauseScreen.applyOn(@parent)
    end
    @chronoUi.updateLabel(@game.time.truncate)
    if @game.currentGuess.grid==@game.correction
      @game.chrono.stop
      @victoryScreen.applyOn(@parent,@game.calculateScore,true, @game.session.gridPick.associatedTimer)
      @game.delete_observers
    elsif @game.time <=0
      @game.chrono.stop
      @victoryScreen.applyOn(@parent,@game.calculateScore,false, @game.session.gridPick.associatedTimer)
      @game.delete_observers
    end
  end

end
