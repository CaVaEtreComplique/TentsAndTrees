# @Author: Corentin Petit <CorentinPetit>
# @Date:   10-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: VictoryScreen.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 12-Feb-2019


require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class VictoryScreen < Screen

  def initialize(parent,game)
    super(parent)
    screen = Gdk::Screen.default
    @gtkObject=Gtk::Table.new(3,3)
    vBox=Gtk::Box.new(:vertical)

    replay=Text.new("Rejouer").resize(screen.width*0.25,screen.height*0.25)

    quit=Text.new("Quitter").resize(screen.width*0.25,screen.height*0.25)
    quit.onClick{
      Gtk.main_quit
    }

    vBox.add(Text.new("Victoire").resize(screen.width*0.8,screen.height*0.8).gtkObject)
    vBox.add(replay.gtkObject)
    vBox.add(quit.gtkObject)

    Gtk::Alignment.new(0.5, 0.2, 0, 0)
    @gtkObject.attach(vBox,0,3,0,1)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end

end
