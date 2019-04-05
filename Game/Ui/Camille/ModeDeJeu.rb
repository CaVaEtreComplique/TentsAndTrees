
# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   25-Jan-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ModeDeJeu.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019



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
#ModeDeJeu is an inherited class from the Screen class. This class only needs
#to be initialized and applied, so the only method is the initializer. It
#creates and implements the game mode choice menu from the game by creating its
#buttons.
#
#==Variables
#The ModeDeJeu class creates the title size, text
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
#=====Here is how a button is implemented on the game mode choice menu :
#
#*First* we add some text to the button :
#   timeA=Text.new("Partie rapide",@widthText,@heightText)
#
#*Next* we add the button we just created in the VBox (gtkObject) :
#   @menu.pack_start(timeA.gtkObject ,expand: false, fill: true, padding: @pad)
#
#*Then* we add the action the button does when it is clicked :
#   timeA.onClick{
#      manager.diffchScreen.applyOn(@parent)
#   }
#
#Here we created a button entitled "Partie rapide" that leads to the difficulty
#choice menu ChoixDiff.
#The other buttons are created by doing this aswell.
#
#*Finally*, when all of the buttons are done we add a background picture with :
#    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
#

class ModeDeJeu < Screen
  def initialize(manager) #:nodoc:
		super(manager.win)
    screen=Gdk::Screen.default

		@pad=screen.height*0.03
    @police=screen.height*0.04

		@gtkObject= Gtk::Table.new(3,3)
		@scrol=ScrollableArea.new(:vertical)
		@boxV=Gtk::Box.new(:vertical)

		@gtkObject.attach(@boxV,0,1,1,2)

	#	@scrol.menu.add(@scrol.menu)
  #Bontons de menu
		titre=Text.new(@textManager.getScreenTexts("gamemode" , "title"),@police*2)
		titre.title
		@boxV.pack_start(titre.gtkObject ,expand: false, fill: false, padding: @pad)

		@boxV.pack_start(@scrol.gtkObject,expand: true, fill: true, padding: @pad)

    aventure=Text.new(@textManager.getButtonLabel("gamemode" , "adventure"),@police)
  	@scrol.add(aventure.gtkObject	,@pad)
		#renvoie la page de jeu du monde aventure
		aventure.onClick{
			manager.levelNumberScreen.applyOn(@parent)
		 }

    timeA=Text.new(@textManager.getButtonLabel("gamemode" , "quick"),@police)
		@scrol.add(timeA.gtkObject,@pad)
		#Renvoie vers la page choix des niveaux
    timeA.onClick{
			 manager.diffchScreen.applyOn(@parent)
    }
    clm=Text.new(@textManager.getButtonLabel("gamemode" , "timeattack"),@police)
		@scrol.add(clm.gtkObject,@pad)
		#Lance une partie contre la montre en mode easy
		clm.onClick{
    	session=TimeAttackSession.new(:timeAttack,:easy)
    	session.createSave
    	manager.runGameSession(session)
		}

		tuto=Text.new("tuto",@police)
		@scrol.add(tuto.gtkObject,@pad)
	 	tuto.onClick{
			session=TutorialSession.new
    	manager.runGameSession(session)
	  }

		save=Text.new(@textManager.getButtonLabel("gamemode" , "save"),@police)
		@scrol.add(save.gtkObject,@pad)
	 save.onClick{
		 #save = Save.load(29)
		 #session = save.content_save
		 #manager.runGameSession(session)
		 manager.listeSaveScreen.applyOn(@parent)
		}

    retour=Text.new(@textManager.getButtonLabel("gamemode" , "back"),@police)
  	@boxV.pack_start(retour.gtkObject ,expand: false, fill: false, padding: @pad)
	 #Renvoie vers la page principale
    retour.onClick{
        manager.mainScreen.applyOn(@parent)
    }

		@gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end
end
