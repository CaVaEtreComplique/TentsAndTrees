# @Author: Corentin Petit <CorentinPetit>
# @Date:   08-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: GameScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 13-Feb-2019



require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../GridUi"
require File.dirname(__FILE__) + "/../Buttons/Button"

class GameScreen < Screen

  attr_reader :gridUi

  def initialize(parent,game,cellAssets)
    super(parent)
    (@game=game).add_observer(self)
    @victoryScreen = VictoryScreen.new(@parent,@game)
    @pauseScreen = PauseScreen.new(@parent,@game,self)

    @gridUi=GridUi.new(game, cellAssets)
    @gtkObject = Gtk::Table.new(3,4)

    screen=Gdk::Screen.default

    buttonHeight = screen.height*0.04
    buttonWidth = screen.width*0.3

    ProcessStatus.send("Chargement des textures")
    newGuess=Text.new("Nouvelle Hypothese",buttonWidth,buttonHeight)
    newGuess.onClick(){
      game.beginGuess
      @gridUi.refresh
    }
    removeGuess=Text.new("Refuter Hypothese",buttonWidth,buttonHeight)
    removeGuess.onClick(){
      game.removeGuess
      @gridUi.refresh
    }
    resetGrid=Text.new("Remettre la grille a zero",buttonWidth,buttonHeight)
    resetGrid.onClick(){
      game.resetGrid
      @gridUi.refresh
    }
    undoButton=Text.new("Annuler",buttonWidth/2,buttonHeight)
    undoButton.onClick(){
      @gridUi.undo
    }
    redoButton=Text.new("Retablir",buttonWidth/2,buttonHeight)
    redoButton.onClick(){
      @gridUi.redo
    }
    help=Text.new("Aide",buttonWidth,buttonHeight)
      help.onClick(){
    }
    pause=Text.new("Pause",buttonWidth*1.1,buttonHeight*1.1)
      pause.onClick(){
        @game.chrono.stop
        @pauseScreen.applyOn(@parent)
    }
    @chronoUi=ChronoUi.new(@game.chrono)
    @chronoUi.run

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

    @gtkObject.attach(globalBox,3,4,1,2)
    @gtkObject.attach(@gridUi.gtkObject, 1, 2, 1, 2)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,3)
  end

  def update
    if @game.currentGuess.grid==@game.correction
      @game.chrono.stop
      @victoryScreen.applyOn(@parent,@chronoUi.gtkLabels.label)
      # @game.delete_observer(self)
    end
  end

end
