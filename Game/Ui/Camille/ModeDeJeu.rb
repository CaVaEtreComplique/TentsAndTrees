# @Author: Corentin Petit <zeigon>
# @Date:   01-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: ModeDeJeu.rb
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

class ModeDeJeu < Screen
  def initialize(manager)
		super(manager.win)
    screen=Gdk::Screen.default
		@pad =10
		@widthTitre=screen.width*0.10
    @heightTitre=screen.height*0.08
    @widthText=screen.width*0.1
    @heightText=screen.height*0.04
    #Menu principal

		@gtkObject= Gtk::Table.new(3,3)
    @menu=Gtk::Box.new(:vertical, 100)
    @gtkObject.attach(@menu,1,2,1,2)

    #Premiere case : titre
		titre=Text.new("Mode de Jeu",@widthTitre,@heightTitre)
		@menu.pack_start(titre.gtkObject ,expand: false, fill: true, padding: @pad)


    #Bontons de menu
    aventure=Text.new("Aventure",@widthText,@heightText)
  	@menu.pack_start(aventure.gtkObject ,expand: false, fill: true, padding: @pad)
		aventure.onClick{

		 }

    timeA=Text.new("Partie rapide",@widthText,@heightText)
		@menu.pack_start(timeA.gtkObject ,expand: false, fill: true, padding: @pad)
		#Renvoie vers la page choix des niveaux
    timeA.onClick{
			 manager.diffchScreen.applyOn(@parent)
    }
    clm=Text.new("Contre la montre",@widthText,@heightText)
		@menu.pack_start(clm.gtkObject ,expand: false, fill: true, padding: @pad)
		#Lance une partie contre la montre
		clm.onClick{
			 session=Session.new(:timeAttack, :random)
			 manager.runGameSession(session)
		}
    retour=Text.new("retour",@widthText,@heightText)
   @menu.pack_start(retour.gtkObject ,expand: false, fill: true, padding: 10)
	 #Renvoie vers la page principale
    retour.onClick{
        manager.mainScreen.applyOn(@parent)
    }

		@gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end
end
