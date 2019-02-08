require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../GridUi"
require File.dirname(__FILE__) + "/../Buttons/GuessUi"

class GameScreen < Screen

  def initialize(parent,game,assets)
    super(parent)
    gridUi=GridUi.new(game, assets)
    @gtkObject = Gtk::Table.new(3,4)

    newGuess=GuessUi.new(:vertical,"Nouvelle Hypothèse")
    newGuess.onClick(){
      game.beginGuess
      gridUi.refresh
    }
    removeGuess=GuessUi.new(:vertical,"Réfuter Hypothèse")
    removeGuess.onClick(){
      game.removeGuess
      gridUi.refresh
    }
    toogleTracer=Button.new(:vertical,"Désactiver le traceur")
    toogleTracer.onClick(){
      if gridUi.toogleTracer
        toogleTracer.updateLabel("Désactiver le traceur")
      else
        toogleTracer.updateLabel("Activer le traceur")
      end
    }
    resetGrid=Button.new(:vertical,"Remettre la grille à zéro")
    resetGrid.onClick(){
      game.resetGrid
      gridUi.refresh
    }
    undoButton=Button.new(:vertical,"Annuler")
    undoButton.onClick(){
      gridUi.undo
    }
    redoButton=Button.new(:vertical,"Rétablir")
    redoButton.onClick(){
      gridUi.redo
    }

    undoRedoBox = Gtk::Box.new(:horizontal)
    undoRedoBox.add(undoButton.gtkObject).add(redoButton.gtkObject)

    leftBox = Gtk::Box.new(:vertical)
    leftBox.add(undoRedoBox).add(resetGrid.gtkObject)

    rightBox = Gtk::Box.new(:vertical)
    rightBox.add(newGuess.gtkObject).add(removeGuess.gtkObject).add(toogleTracer.gtkObject)

    globalBox = Gtk::Box.new(:vertical)
    globalBox.add(leftBox).add(rightBox)

    @gtkObject.attach(globalBox,3,4,1,2)
    @gtkObject.attach(gridUi.gtkObject, 1, 2, 1, 2)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,4,0,3)
  end

end
