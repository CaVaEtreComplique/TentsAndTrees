# @Author: Corentin Petit <CorentinPetit>
# @Date:   08-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: GameScreen.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 12-Feb-2019



require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../GridUi"
require File.dirname(__FILE__) + "/../Buttons/Button"

class GameScreen < Screen

  def initialize(parent,game,cellAssets)
    super(parent)
    @game=game.add_observer(self)
    @victoryScreen = VictoryScreen.new(@parent,@game)

    gridUi=GridUi.new(game, cellAssets)
    @gtkObject = Gtk::Table.new(3,4)

    screen=Gdk::Screen.default

    ProcessStatus.send("Chargement des textures")
    newGuess=Text.new("Nouvelle Hypothese",screen.width*0.28,screen.height*0.28)
    newGuess.onClick(){
      game.beginGuess
      gridUi.refresh
    }
    removeGuess=Text.new("Refuter Hypothese",screen.width*0.28,screen.height*0.28)
    removeGuess.onClick(){
      game.removeGuess
      gridUi.refresh
    }
    toogleTracer=Text.new("Desactiver le traceur",screen.width*0.28,screen.height*0.28)
    toogleTracer.onClick(){
      if gridUi.toogleTracer
        toogleTracer.updateLabel("Desactiver le traceur",screen.width*0.28,screen.height*0.28)
      else
        toogleTracer.updateLabel("Activer le traceur",screen.width*0.28,screen.height*0.28)
      end
    }
    resetGrid=Text.new("Remettre la grille a zero",screen.width*0.28,screen.height*0.28)
    resetGrid.onClick(){
      game.resetGrid
      gridUi.refresh
    }
    undoButton=Text.new("Annuler",screen.width*0.14,screen.height*0.28)
    undoButton.onClick(){
      gridUi.undo
    }
    redoButton=Text.new("Retablir",screen.width*0.14,screen.height*0.28)
    redoButton.onClick(){
      gridUi.redo
    }

    undoRedoBox = Gtk::Box.new(:horizontal)
    undoRedoBox.pack_start(undoButton.gtkObject, expand: false, fill: false, padding: 10)
    undoRedoBox.pack_start(redoButton.gtkObject, expand: false, fill: false, padding: 10)
    ali=Gtk::Alignment.new(0.5, 0.2, 0, 0).add(undoRedoBox)

    globalBox = Gtk::Box.new(:vertical  )
    globalBox.pack_start(ali, expand: false, fill: false, padding: 10)
    globalBox.pack_start(resetGrid.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(newGuess.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(removeGuess.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(toogleTracer.gtkObject, expand: false, fill: false, padding: 10)

    @gtkObject.attach(globalBox,3,4,1,2)
    @gtkObject.attach(gridUi.gtkObject, 1, 2, 1, 2)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,3)
  end

  def update
    @victoryScreen.applyOn(@parent)
  end

end
