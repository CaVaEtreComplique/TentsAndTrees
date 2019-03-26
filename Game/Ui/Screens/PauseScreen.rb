# @Author: Corentin Petit <zeigon>
# @Date:   13-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: PauseScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 25-Mar-2019



require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../Camille/Diapo"

class PauseScreen < Screen

  def initialize(gameScreen,manager,game)
    super(manager.win)
    screen = Gdk::Screen.default
    @gtkObject=Gtk::Table.new(3,3)

    @game=game
    @gameScreen=gameScreen

    buttonHeight = screen.height*0.04
    buttonWidth = screen.width*0.3

    resume=Text.new(@textManager.getButtonLabel("pause" , "resume"),buttonWidth*1.1,buttonHeight*1.1)
      resume.onClick(){
        @gameScreen.applyOn(@parent)
        @game.chrono.continue
    }
    toogleTracer=Text.new(@textManager.getButtonLabel("pause" , "disabletracker"),buttonWidth,buttonHeight)
    toogleTracer.onClick(){
      if @gameScreen.gridUi.toogleTracer
        toogleTracer.updateLabel(@textManager.getButtonLabel("pause" , "disabletracker"),buttonWidth,buttonHeight)
      else
        toogleTracer.updateLabel(@textManager.getButtonLabel("pause" , "enabletracker"),buttonWidth,buttonHeight)
      end
    }

    toogleCountIndicators=Text.new(@textManager.getButtonLabel("pause" , "disableindicators"),buttonWidth,buttonHeight)
    toogleCountIndicators.onClick(){
      if @gameScreen.gridUi.toogleCountIndicators
        toogleCountIndicators.updateLabel(@textManager.getButtonLabel("pause" , "disableindicators"),buttonWidth,buttonHeight)
      else
        toogleCountIndicators.updateLabel(@textManager.getButtonLabel("pause" , "disableindicators"),buttonWidth,buttonHeight)
      end
    }
    quit=Text.new(@textManager.getButtonLabel("pause" , "quit"),buttonWidth*1.1,buttonHeight*1.1)
      quit.onClick(){
        manager.createNewSave
        @game.delete_observers
        manager.mainScreen.applyOn(@parent)
    }

    diapo = Diapo.new(screen.width*0.45,screen.height*0.45)
    diapo.box.signal_connect("button_press_event"){diapo.nuImage}

    globalBox=Gtk::Box.new(:vertical)
    globalBox.pack_start(resume.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(toogleTracer.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(toogleCountIndicators.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(quit.gtkObject, expand: false, fill: false, padding: 10)
    globalBox.pack_start(diapo.box, expand: false, fill: false, padding: 100)

    Gtk::Alignment.new(0.5, 0.2, 0, 0)
    @gtkObject.attach(globalBox,0,3,0,1)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end

end
