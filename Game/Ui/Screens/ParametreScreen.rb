
# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   8-Feb-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: Parametre.rb
# @Last modified by:   zeigon
# @Last modified time: 28-Mar-2019

require 'gtk3'
require File.dirname(__FILE__) + "/../Screens/GameModeScreen"
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

##
# ===== Presentation
# ParametreScreen is an inherited class from the Screen class. This class only needs
# to be initialized and applied, so the only method is the initializer. It
# creates and implements the settings menu from the game by creating its buttons.
#
# ===== Variables
# The ParametreScreen class creates the title size, text size and the padding
# variables with :
#     @pad =10
#     @widthTitre=screen.width*0.10
#     @heightTitre=screen.height*0.08
#     @widthText=screen.width*0.08
#     @heightText=screen.height*0.05
#
# This class also inherits the screen variable from the Screen class.
#
# The gtkObject is the table where the menu (a vertical box) is added to create
# the menu buttons.
#
# ===== Implementation
# Here is how the language choice is implemented on this screen :
#
# *First* we create the variables :
#      fr ="Francais"
#      ang="Anglais"
#      languageButton=Gtk::ComboBoxText.new
#
# The languageButton variable is a combo box, making it easier for the player to choose.
#
# *Next* we add our combo box to the menu
#      @menu.add(languageButton=Gtk::ComboBoxText.new)
#
# *Then* we add the action each possibility of the box does when it is clicked :
#      languageButton.append_text(fr)
#      languageButton.append_text(ang)
#
# Here we created a combo box with two possible languages, French and English.
# The other buttons are created by doing this aswell.
#
# *Finally*, when all of the buttons are done we add a background picture with :
#       @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
#
class ParametreScreen < Screen
	#:nodoc:
  def initialize(manager)

    super(manager.win)
			#Variable de l'ecran
		screen = Constants::SCREEN
		@pad=Constants::BUTTON_PADDING

    @gtkObject= Gtk::Table.new(3,3)
    @menu=Gtk::Box.new(:vertical)
    @gtkObject.attach(@menu,1,2,1,2)
		 languageButton=Gtk::ComboBoxText.new
		# fr ="french"
		# ang="english"

    titre=Text.new(@textManager.getScreenTexts("settings" , "title"))
		titre.title
		appli=Text.new(@textManager.getButtonLabel("settings" , "apply"))
		desins=Text.new(@textManager.getButtonLabel("settings" , "unregister"))
		retour=Text.new(@textManager.getButtonLabel("settings" , "back"))


		@menu.pack_start(titre.gtkObject ,expand: false, fill: true, padding: @pad)
		@menu.add(languageButton=Gtk::ComboBoxText.new)
		@menu.pack_start(appli.gtkObject ,expand: false, fill: true, padding:@pad)
		@menu.pack_start(desins.gtkObject ,expand: false, fill: true, padding:@pad)
		@menu.pack_start(retour.gtkObject ,expand: false, fill: true, padding: @pad)

		# languageButton.append_text(fr)
		# languageButton.append_text(ang)
		language = @textManager.getLanguages
		language.each{ |v|
			languageButton.append_text(v)
		}

    appli.onClick{
			if languageButton.active_text != @textManager.language && languageButton.active_text != nil
	     	@textManager.language=languageButton.active_text
				manager.update
				manager.mainScreen.applyOn(@parent)
			end
    }
		desins.onClick{
			connect = ConnectDB.new
			connect.deletePlayerSave(Connexion.getJoueur.id_player)
			connect.deletePlayerHg(Connexion.getJoueur.id_player)
			connect.deletePlayer(Connexion.getJoueur.id_player)
			TestGame.hide
			Connexion.new
		}
    retour.onClick{
        manager.mainScreen.applyOn(@parent)
    }
		#Fond d'ecran
  @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)

  end
end
