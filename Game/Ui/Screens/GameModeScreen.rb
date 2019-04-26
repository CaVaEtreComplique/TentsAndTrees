
# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   25-Jan-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ModeDeJeu.rb
# @Last modified by:   zeigon
# @Last modified time: 26-Apr-2019



require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

##
# ===== Presentation
# GameModeScreen is an inherited class from the Screen class. This class only needs
# to be initialized and applied, so the only method is the initializer. It
# creates and implements the game mode choice menu from the game by creating its
# buttons.
#
# ===== Variables
# The GameModeScreen class creates the title size, text
# size and the padding variables with :
#   @pad =10
#   @widthTitre=screen.width*0.10
#   @heightTitre=screen.height*0.08
#   @widthText=screen.width*0.1
#   @heightText=screen.height*0.04
#
# This class also inherits the screen variable from the Screen class.
#
# The gtkObject is the table where the menu (a vertical box) is added to create
# the menu buttons.
#
# ===== Implementation
# Here is how a button is implemented on the game mode choice menu :
#
# *First* we add some text to the button :
#   timeA=Text.new("Partie rapide",@widthText,@heightText)
#
# *Next* we add the button we just created in the VBox (gtkObject) :
#   @menu.pack_start(timeA.gtkObject ,expand: false, fill: true, padding: @pad)
#
# *Then* we add the action the button does when it is clicked :
#   timeA.onClick{
#      manager.diffchScreen.applyOn(@parent)
#   }
#
# Here we created a button entitled "Partie rapide" that leads to the difficulty
# choice menu ChoixDiffScreen.
# The other buttons are created by doing this aswell.
#
# *Finally*, when all of the buttons are done we add a background picture with :
#    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
class GameModeScreen < Screen
  def initialize(manager) #:nodoc:
		super(manager.win)
		screen = Constants::SCREEN

		@pad=Constants::BUTTON_PADDING


		@gtkObject= Gtk::Table.new(3,3)
		@scrol=ScrollableArea.new(:vertical)
		@boxV=Gtk::Box.new(:vertical)

		@gtkObject.attach(@boxV,0,1,1,2)



		titre=Text.new(@textManager.getScreenTexts("gamemode" , "title"))
		titre.title
		aventure=Text.new(@textManager.getButtonLabel("gamemode" , "adventure"))
		timeA=Text.new(@textManager.getButtonLabel("gamemode" , "quick"))
		clm=Text.new(@textManager.getButtonLabel("gamemode" , "timeattack"))
		tuto=Text.new(@textManager.getButtonLabel("gamemode" , "tuto"))
		save=Text.new(@textManager.getButtonLabel("gamemode" , "save"))
		retour=Text.new(@textManager.getButtonLabel("gamemode" , "back"))

		@boxV.pack_start(titre.gtkObject ,expand: false, fill: false, padding: @pad)
		@boxV.pack_start(@scrol.gtkObject,expand: true, fill: true, padding: @pad)
  	@scrol.add(aventure.gtkObject	,@pad)
		@scrol.add(timeA.gtkObject,@pad)
		@scrol.add(clm.gtkObject,@pad)
		@scrol.add(tuto.gtkObject,@pad)
		@scrol.add(save.gtkObject,@pad)
		@boxV.pack_start(retour.gtkObject ,expand: false, fill: false, padding: @pad)


		aventure.onClick{
			session = AdventureSession.new
			manager.runAdventureSession(session)
    	session.createSave
		 }

    timeA.onClick{
			 manager.diffchScreen.applyOn(@parent)
    }
		clm.onClick{
    	session=TimeAttackSession.new(:random)
    	session.createSave
    	manager.runGameSession(session)
		}
    tuto.onClick{
			session=TutorialSession.new
    	manager.runGameSession(session)
	  }
	 save.onClick{
		 manager.listeSaveScreen.applyOn(@parent)
		}
    retour.onClick{
        manager.mainScreen.applyOn(@parent)
    }

		@gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end
end
