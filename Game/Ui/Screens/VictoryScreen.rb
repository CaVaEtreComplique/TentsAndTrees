# @Author: Corentin Petit <CorentinPetit>
# @Date:   10-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: VictoryScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 18-Mar-2019


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

    @scoreText=Text.new("sScore non charge").resize(screen.width*0.25,screen.height*0.1)
    @resultText=Text.new("Victoire").resize(screen.width*0.8,screen.height*0.20)
    vBox.pack_start(@resultText.gtkObject, expand: false, fill: true, padding: 50)
    vBox.pack_start(@scoreText.gtkObject, expand: false, fill: true, padding: 40)

    @replay=Text.new("Continuer").resize(screen.width*0.25,screen.height*0.1)
    vBox.pack_start(@replay.gtkObject, expand: false, fill: true, padding: 20)

    quit=Text.new("Quitter").resize(screen.width*0.25,screen.height*0.1)
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
    @scoreText.updateLabel("Score "+@score.to_s,screen.width*0.25,screen.height*0.05)
    if !isWon
      @resultText.updateLabel("Defaite",screen.width*0.8,screen.height*0.20)
    end
    if !isWon || !@session.continuable?
      if @session.partOfAdventure?
      else
        @replay.updateLabel("Rejouer",screen.width*0.25,screen.height*0.1)
        @replay.onClick{
          @session.replay(false)
          @manager.runGameSession(@session)
        }
      end
    else
      @replay.onClick{
        @session.replay(true)
        @manager.runGameSession(@session)
      }
    end
    super(widget)
  end

end
