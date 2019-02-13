# @Author: Corentin Petit <CorentinPetit>
# @Date:   10-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: VictoryScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 13-Feb-2019


require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class VictoryScreen < Screen

  def initialize(parent,game)
    super(parent)
    screen = Gdk::Screen.default
    @gtkObject=Gtk::Table.new(3,3)
    vBox=Gtk::Box.new(:vertical)

    replay=Text.new("Rejouer").resize(screen.width*0.25,screen.height*0.1)

    quit=Text.new("Quitter").resize(screen.width*0.25,screen.height*0.1)
    quit.onClick{
      Gtk.main_quit
    }

    @scoreText=Text.new("sTime non charge").resize(screen.width*0.25,screen.height*0.1)
    @resultText=Text.new("Victoire").resize(screen.width*0.8,screen.height*0.20)
    vBox.pack_start(@resultText.gtkObject, expand: false, fill: true, padding: 50)
    vBox.pack_start(@scoreText.gtkObject, expand: false, fill: true, padding: 40)
    vBox.pack_start(replay.gtkObject, expand: false, fill: true, padding: 20)
    vBox.pack_start(quit.gtkObject, expand: false, fill: true, padding:20)

    Gtk::Alignment.new(0.5, 0.2, 0, 0)
    @gtkObject.attach(vBox,0,3,0,1)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end

  def applyOn(widget,sTime,result)
    screen = Gdk::Screen.default
    @scoreText.updateLabel("Temps "+sTime,screen.width*0.25,screen.height*0.05)
    @resultText.updateLabel("Defaite",screen.width*0.8,screen.height*0.20) unless result
    super(widget)
  end

end
