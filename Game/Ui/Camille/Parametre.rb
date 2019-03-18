
# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   8-Feb-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: Parametre.rb
# @Last modified by:   zeigon
# @Last modified time: 18-Mar-2019

require 'gtk3'
require File.dirname(__FILE__) + "/ModeDeJeu"
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

##
#==Presentation
#Parametre is an inherited class from the Screen class. This class only needs
#to be initialized and applied, so the only method is the initializer. It
#creates and implements the language choice menu from the game by creating its
#buttons.
#
#==Variables
#The Parametre class creates the title size, text
#size and the padding variables with :
#     @pad =10
#     @widthTitre=screen.width*0.10
#     @heightTitre=screen.height*0.08
#     @widthText=screen.width*0.08
#     @heightText=screen.height*0.05
#
#This class also inherits the screen variable from the Screen class.
#
#The gtkObject is the table where the menu (a vertical box) is added to create
#the menu buttons.
#
#==Implementation
#=====Here is how the language choice is implemented on this screen :
#
#*First* we create the variables :
#      fr ="Francais"
#      ang="Anglais"
#      langue=Gtk::ComboBoxText.new
#
#The langue variable is a combo box, making it easier for the player to choose.
#
#*Next* we add our combo box to the menu
#      @menu.add(langue=Gtk::ComboBoxText.new)
#
#*Then* we add the action each possibility of the box does when it is clicked :
#      langue.append_text(fr)
#      langue.append_text(ang)
#
#Here we created a combo box with two possible languages, French and English.
#The other buttons are created by doing this aswell.
#
#*Finally*, when all of the buttons are done we add a background picture with :
#       @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
#
class Parametre < Screen
	#:nodoc:
  def initialize(manager)

    super(manager.win)
			#Variable de l'ecran
    screen=Gdk::Screen.default
		#Variable pour resize le texte
	  @pad =10
		@widthTitre=screen.width*0.10
    @heightTitre=screen.height*0.08
    @widthText=screen.width*0.08
    @heightText=screen.height*0.05

    @gtkObject= Gtk::Table.new(3,3)
    @menu=Gtk::Box.new(:vertical, 100)
    @gtkObject.attach(@menu,1,2,1,2)

  #Bontons de menu
    titre=Text.new(@textManager.getScreenTexts("settings" , "title"),@widthTitre,@heightTitre)
		@menu.pack_start(titre.gtkObject ,expand: false, fill: true, padding: @pad)

    #Menu deroulant des langues
    fr ="french"
    ang="english"
    langue=Gtk::ComboBoxText.new
  #  @menu.pack_start(langue.gtkObject ,expand: false, fill: true, padding: 10)
    @menu.add(langue=Gtk::ComboBoxText.new)
    langue.append_text(fr)
    langue.append_text(ang)



    appli=Text.new(@textManager.getButtonLabel("settings" , "apply"),@widthText,@heightText)
    @menu.pack_start(appli.gtkObject ,expand: false, fill: true, padding:@pad)
    appli.onClick{
      @textManager.language=langue.active_text
			manager.update
			manager.mainScreen.applyOn(@parent)
    }

    retour=Text.new(@textManager.getButtonLabel("settings" , "back"),@widthText,@heightText)
    @menu.pack_start(retour.gtkObject ,expand: false, fill: true, padding: @pad)
		#Renvoie sur la page principale
    retour.onClick{
        manager.mainScreen.applyOn(@parent)
    }
		#Fond d'ecran
  @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)

  end
end
