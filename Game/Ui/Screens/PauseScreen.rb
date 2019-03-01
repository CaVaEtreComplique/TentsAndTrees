# @Author: Corentin Petit <zeigon>
# @Date:   13-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: PauseScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 01-Mar-2019



require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class PauseScreen < Screen

  def initialize(gameScreen,manager,game)
    super(manager.win)
    screen = Gdk::Screen.default
    @gtkObject=Gtk::Table.new(3,3)

    @game=game
    @gameScreen=gameScreen

    buttonHeight = screen.height*0.04
    buttonWidth = screen.width*0.3

    resume=Text.new("reprendre",buttonWidth*1.1,buttonHeight*1.1)
      resume.onClick(){
        @gameScreen.applyOn(@parent)
        @game.chrono.continue
    }
    toogleTracer=Text.new("Desactiver le traceur",buttonWidth,buttonHeight)
    toogleTracer.onClick(){
      if @gameScreen.gridUi.toogleTracer
        toogleTracer.updateLabel("Desactiver le traceur",buttonWidth,buttonHeight)
      else
        toogleTracer.updateLabel("Activer le traceur",buttonWidth,buttonHeight)
      end
    }

    toogleCountIndicators=Text.new("Desactiver les Indicateurs",buttonWidth,buttonHeight)
    toogleCountIndicators.onClick(){
      if @gameScreen.gridUi.toogleCountIndicators
        toogleCountIndicators.updateLabel("Desactiver les Indicateurs",buttonWidth,buttonHeight)
      else
        toogleCountIndicators.updateLabel("Activer les Indicateurs",buttonWidth,buttonHeight)
      end
    }
    quit=Text.new("Quitter",buttonWidth*1.1,buttonHeight*1.1)
      quit.onClick(){
        manager.mainScreen.applyOn(@parent)
    }

    globalBox=Gtk::Box.new(:vertical)
    globalBox.pack_start(resume.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(toogleTracer.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(toogleCountIndicators.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(quit.gtkObject, expand: false, fill: false, padding: 10)

    Gtk::Alignment.new(0.5, 0.2, 0, 0)
    @gtkObject.attach(globalBox,0,3,0,1)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end

end
