# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ChoixDiff.rb
# @Last modified by:   zeigon
# @Last modified time: 28-Mar-2019

require 'gtk3'
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

##
#==Presentation
#ChoixDiff is an inherited class from the Screen class. This class only needs
#to be initialized and applied, so the only method is the initializer. It
#creates and implements the difficulty choice menu from the game by creating its
#buttons.
#
#==Variables
#The ChoixDiff class creates the title size, text
#size and the padding variables with :
#   @pad =10
#   @widthTitre=screen.width*0.10
#   @heightTitre=screen.height*0.08
#   @widthText=screen.width*0.1
#   @heightText=screen.height*0.04
#
#This class also inherits the screen variable from the Screen class.
#
#The gtkObject is the table where the menu (a vertical box) is added to create
#the menu buttons.
#
#==Implementation
#=====Here is how a button is implemented on the difficulty choice menu :
#
#*First* we add some text to the button :
#   facile=Text.new("Facile",@widthText,@heightText)
#
#*Next* we add the button we just created in the VBox (gtkObject) :
#   @menu.pack_start(facile.gtkObject ,expand: false, fill: true, padding: @pad)
#
#*Then* we add the action the button does when it is clicked :
#    facile.onClick{
#	     session=Session.new(:quickplay, :easy)
#	     manager.runGameSession(session)
#    }
#
#Here we created a button entitled "Jouer" that leads to the game screen.
#The other buttons are created by doing this aswell.
#
#*Finally*, when all of the buttons are done we add a background picture with :
#    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
#
class ChoixDiff < Screen
  def initialize(manager) #:nodoc:
    super(manager.win)
    screen=Gdk::Screen.default
		#Variable pour resize le texte
    @pad =10
    @widthTitre=screen.width*0.10
    @heightTitre=screen.height*0.08
    @widthText=screen.width*0.1
    @heightText=screen.height*0.04
		#Variable de l'ecran
    screen=Gdk::Screen.default


    @gtkObject= Gtk::Table.new(3,3)
    @menu=Gtk::Box.new(:vertical, 100)
    @gtkObject.attach(@menu,1,2,1,2)
  #Bontons de menu
    titre=Text.new(@textManager.getScreenTexts("difficulty" , "title"))
		titre.title
		  #add sur gtkObject
    @menu.pack_start(titre.gtkObject ,expand: false, fill: true, padding: @pad)

    facile=Text.new(@textManager.getButtonLabel("difficulty" , "easy"))
		 @menu.pack_start(facile.gtkObject ,expand: false, fill: true, padding: @pad)
		 #Renvoie sur la page de jeu en mode partie rapide niveau easy
		facile.onClick{
			 session=QuickPlaySession.new(:quickplay, :easy)
			 manager.runGameSession(session)
		}
    moyen=Text.new(@textManager.getButtonLabel("difficulty" , "normal"))
		 @menu.pack_start(moyen.gtkObject ,expand: false, fill: true, padding: @pad)
		  #Renvoie sur la page de jeu en mode partie rapide niveau moyen
		moyen.onClick{
			 session=QuickPlaySession.new(:quickplay, :medium)
			 manager.runGameSession(session)
		}
    diff=Text.new(@textManager.getButtonLabel("difficulty" , "hard"))
		 @menu.pack_start(diff.gtkObject ,expand: false, fill: true, padding: @pad)
		  #Renvoie sur la page de jeu en mode partie rapide niveau difficile
		diff.onClick{
			 session=QuickPlaySession.new(:quickplay, :hard)
			 manager.runGameSession(session)
		}
    retour=Text.new(@textManager.getButtonLabel("difficulty" , "back"))
    @menu.pack_start(retour.gtkObject ,expand: false, fill: true, padding: 10)
		 #Renvoie sur la page mode de jeu
    retour.onClick{
        manager.modeScreen.applyOn(@parent)
    }
		#fond d'ecran
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)

end

end
