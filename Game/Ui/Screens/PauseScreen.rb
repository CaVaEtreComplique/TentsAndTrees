# @Author: Corentin Petit <zeigon>
# @Date:   13-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: PauseScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 28-Mar-2019



require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../Diapo"

class PauseScreen < Screen

  def initialize(gameScreen,manager,game)
    super(manager.win)
    screen = Constants::SCREEN
    @pad=Constants::BUTTON_PADDING/3
    @gtkObject=Gtk::Table.new(3,3)
    @bjr = Gtk::Alignment.new(0.5, 0, 0, 0)

    @game=game
    @gameScreen=gameScreen

    buttonHeight = screen.height*0.04
    buttonWidth = screen.width*0.3

    resume=Text.new(@textManager.getButtonLabel("pause" , "resume"))
      resume.onClick(){
        @gameScreen.applyOn(@parent)
        @game.chrono.continue
    }
    toogleTracer=Text.new(@textManager.getButtonLabel("pause" , "disabletracker"))
    toogleTracer.onClick(){
      if @gameScreen.gridUi.toogleTracer
        toogleTracer.updateLabel(@textManager.getButtonLabel("pause" , "disabletracker"))
      else
        toogleTracer.updateLabel(@textManager.getButtonLabel("pause" , "enabletracker"))
      end
    }

    toogleCountIndicators=Text.new(@textManager.getButtonLabel("pause" , "disableindicators"))
    toogleCountIndicators.onClick(){
      if @gameScreen.gridUi.toogleCountIndicators
        toogleCountIndicators.updateLabel(@textManager.getButtonLabel("pause" , "disableindicators"))
      else
        toogleCountIndicators.updateLabel(@textManager.getButtonLabel("pause" , "enableindicators"))
      end
    }
    quit=Text.new(@textManager.getButtonLabel("pause" , "quit"))
      quit.onClick(){
        if !@game.session.partOfAdventure?
          @game.delete_observers
          manager.session.updateSave
          manager.updateSave
          manager.mainScreen.applyOn(@parent)
        else
          @game.session.game.delete_observers
          @game.session.game.clearHelper
          manager.levelNumberScreen.applyOn(@parent)
        end
        ["TERM", "INT", "QUIT"].each{ |sig|
          Signal.trap(sig) { exit }
        }
    }

    diapo = Diapo.new(screen.width*0.45,screen.height*0.45,@textManager,manager.ic)
    diapo.nextButton.signal_connect("button_press_event"){diapo.nextImage}
    diapo.previousButton.signal_connect("button_press_event"){diapo.previousImage}
    @bjr.add(diapo.box)


    globalBox=Gtk::Box.new(:vertical)
    globalBox.pack_start(resume.gtkObject, expand: false, fill: false, padding: @pad)
    globalBox.pack_start(toogleTracer.gtkObject, expand: false, fill: false, padding: @pad)
    globalBox.pack_start(toogleCountIndicators.gtkObject, expand: false, fill: false, padding: @pad)
    globalBox.pack_start(quit.gtkObject, expand: false, fill: false, padding: @pad)
    globalBox.pack_start(@bjr, expand: false, fill: false, padding:@pad)
    @gtkObject.attach(globalBox,0,3,0,1)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end

end
