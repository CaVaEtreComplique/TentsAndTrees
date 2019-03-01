# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: ChoixDiff.rb
# @Last modified by:   zeigon
# @Last modified time: 01-Mar-2019



require 'gtk3'
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

class ChoixDiff < Screen
  def initialize(manager)
    super(manager.win)
    screen=Gdk::Screen.default
    @pad =10
    @widthTitre=screen.width*0.10
    @heightTitre=screen.height*0.08
    @widthText=screen.width*0.1
    @heightText=screen.height*0.04
    screen=Gdk::Screen.default
    #menuV=box verticale
    @gtkObject= Gtk::Table.new(3,3)
    @menu=Gtk::Box.new(:vertical, 100)
    @gtkObject.attach(@menu,1,2,1,2)

    titre=Text.new("Choix du niveau",@widthTitre,@heightTitre)
    @menu.pack_start(titre.gtkObject ,expand: false, fill: true, padding: @pad)

    facile=Text.new("Facile",@widthText,@heightText)
		 @menu.pack_start(facile.gtkObject ,expand: false, fill: true, padding: @pad)
		facile.onClick{
			 session=Session.new(:quickplay, :easy)
			 manager.runGameSession(session)
		}
    moyen=Text.new("Moyen",@widthText,@heightText)
		 @menu.pack_start(moyen.gtkObject ,expand: false, fill: true, padding: @pad)
		moyen.onClick{
			 session=Session.new(:quickplay, :medium)
			 manager.runGameSession(session)
		}
    diff=Text.new("Difficile",@widthText,@heightText)
		 @menu.pack_start(diff.gtkObject ,expand: false, fill: true, padding: @pad)
		diff.onClick{
			 session=Session.new(:quickplay, :hard)
			 manager.runGameSession(session)
		}
    retour=Text.new("retour",@widthText,@heightText)
    @menu.pack_start(retour.gtkObject ,expand: false, fill: true, padding: 10)
    retour.onClick{
        manager.modeScreen.applyOn(@parent)
    }
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)

end












end
