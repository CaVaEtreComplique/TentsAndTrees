# @Author: Corentin Petit <CorentinPetit>
# @Date:   08-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: GameScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 25-Mar-2019



require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../GridUi"
require File.dirname(__FILE__) + "/../HelpUi"
require File.dirname(__FILE__) + "/../Buttons/Button"

class GameScreen < Screen

  attr_reader :gridUi

  attr_writer :helpDisplayed

  def initialize(manager,game,cellAssets,victoryScreen)
    super(manager.win)
    (@game=game).add_observer(self)
    @victoryScreen = victoryScreen
    @pauseScreen = PauseScreen.new(self,manager,@game)

    @gridUi=GridUi.new(game, cellAssets,self)
    @gtkObject = Gtk::Table.new(3,4)

    screen=Gdk::Screen.default

    buttonHeight = screen.height*0.04
    buttonWidth = screen.width*0.3

    ProcessStatus.send(@textManager.getLoadingMessages("textures"))
    newGuess=Text.new(@textManager.getButtonLabel("ingame" , "newguess"),buttonWidth,buttonHeight)
    newGuess.onClick(){
      game.beginGuess
      @gridUi.refresh
    }
    removeGuess=Text.new(@textManager.getButtonLabel("ingame" , "refuteguess"),buttonWidth,buttonHeight)
    removeGuess.onClick(){
      game.removeGuess
      @gridUi.refresh
    }
    resetGrid=Text.new(@textManager.getButtonLabel("ingame" , "rz"),buttonWidth,buttonHeight)
    resetGrid.onClick(){
      game.resetGrid
      @gridUi.refresh
    }
    undoButton=Text.new(@textManager.getButtonLabel("ingame" , "undo"),buttonWidth/2,buttonHeight)
    undoButton.onClick(){
      @gridUi.undo
    }
    redoButton=Text.new(@textManager.getButtonLabel("ingame" , "redo"),buttonWidth/2,buttonHeight)
    redoButton.onClick(){
      @gridUi.redo
    }

    @helpResponseUi = HelpUi.new
    help=Text.new(@textManager.getButtonLabel("ingame" , "help"),buttonWidth,buttonHeight)
    help.onClick(){
      # Display the help message
      @helpCR=@game.help
      @helpResponseUi.update(@helpCR[0])
      self.helpDisplayed=true
      #  Make the concerned cells golw
      @helpCR[1].each{ |cell|
        cellUi= gridUi.cells[cell.row][cell.column]
        cellUi.glowing
      }
    }

    pause=Text.new(@textManager.getButtonLabel("ingame" , "pause"),buttonWidth*1.1,buttonHeight*1.1)
      pause.onClick(){
        @game.chrono.stop
        @pauseScreen.applyOn(@parent)
    }

    @chronoUi=ChronoUi.new(@game.time.truncate)

    # helpResponse = HelplUi.new

    undoRedoBox = Gtk::Box.new(:horizontal)
    undoRedoBox.pack_start(undoButton.gtkObject, expand: false, fill: false, padding: 10)
    undoRedoBox.pack_start(redoButton.gtkObject, expand: false, fill: false, padding: 10)
    aliURB=Gtk::Alignment.new(0.5, 0.2, 0, 0).add(undoRedoBox)
    aliPause=Gtk::Alignment.new(1, 0.2, 0, 0).add(pause.gtkObject)

    globalBox = Gtk::Box.new(:vertical  )
    globalBox.pack_start(aliPause, expand: false, fill: true, padding: 10)
    globalBox.pack_start(@chronoUi.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(aliURB, expand: false, fill: false, padding: 10)
    globalBox.pack_start(resetGrid.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(newGuess.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(removeGuess.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(help.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(@helpResponseUi.gtkObject, expand: false, fill: false, padding: 20)


    @gtkObject.attach(globalBox,3,4,1,2)
    @gtkObject.attach(@gridUi.gtkObject, 1, 2, 1, 2)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,3)
  end

  def gridAltered
    if helpDisplayed?
      @helpResponseUi.update
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
      @victoryScreen.applyOn(@parent,@game.calculateScore,true)
      @game.delete_observers
    elsif @game.time.truncate <=0
      @game.chrono.stop
      @victoryScreen.applyOn(@parent,@game.calculateScore,false)
      @game.delete_observers
    end
  end

end
