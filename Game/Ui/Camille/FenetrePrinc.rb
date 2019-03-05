
# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   25-Jan-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: FenetrePrinc.rb
# @Last modified by:   CamilleVAIDIE
# @Last modified time: 1-Mar-2019

require 'gtk3'
require File.dirname(__FILE__) + "/ModeDeJeu"
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"
require File.dirname(__FILE__) + "/../Buttons/Text"

##
#==Presentation
#FenetrePrinc is an inherited class from the Screen class. This class only needs
#to be initialized and applied, so the only method is the initializer. It
#creates and implements the main menu from the game by creating its buttons.
#
#==Variables
#The FenetrePrinc class creates the title size, text
#size and the padding variables with :
#   @pad=30
#   @widthTitre=screen.width*0.10
#   @heightTitre=screen.height*0.08
#   @widthText=screen.width*0.15
#   @heightText=screen.height*0.04
#
#This class also inherits the screen variable from the Screen class.
#
#The gtkObject is the Table where the menuV (a vertical box) is added to create
#the menu buttons.
#
#==Implementation
#=====Here is how a button is implemented on the main menu :
#
#*First* we add some text to the button :
#   jouer=Text.new("jouer",@widthText,@heightText)
#
#*Next* we add the button we just created in the VBox (gtkObject) :
#   @menuV.pack_start(jouer.gtkObject ,expand: false, fill: true, padding: @pad)
#
#*Then* we add the action the button does when it is clicked :
#   jouer.onClick{
#      manager.modeScreen.applyOn(@parent)
#   }
#Here we created a button entitled "Jouer" that leads to the game mode menu.
#The other buttons are created by doing this aswell.
#
#*Finally*, when all of the buttons are done we add a background picture with :
#   @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
#

class FenetrePrinc < Screen
  def initialize(manager) #:nodoc:
    super(manager.win)
    screen=Gdk::Screen.default
    #Variable pour resize le texte
    @pad=30
    @widthTitre=screen.width*0.10
    @heightTitre=screen.height*0.08
    @widthText=screen.width*0.15
    @heightText=screen.height*0.04

    @gtkObject= Gtk::Table.new(3,3)
    @menuV=Gtk::Box.new(:vertical)
    @gtkObject.attach(@menuV,1,2,0,1)

    titre=Text.new("dEs ArbrEs Et dEs tEntEs",@widthTitre,@heightTitre)
    #add sur gtkObject
    @menuV.pack_start(titre.gtkObject ,expand: false, fill: true, padding: @pad)

    jouer=Text.new("jouer",@widthText,@heightText)
    #add sur gtkObject
    @menuV.pack_start(jouer.gtkObject ,expand: false, fill: true, padding: @pad)
    #Renvoie vers la page Mode de jeu
    jouer.onClick{
        manager.modeScreen.applyOn(@parent)
    }

    parametre=Text.new("parametres",@widthText,@heightText)
    #add sur gtkObject
    @menuV.pack_start(parametre.gtkObject ,expand: false, fill: true, padding: @pad)
    #Renvoie vers la page parametre
    parametre.onClick{
        manager.paramScreen.applyOn(@parent)
    }
    regle=Text.new("regle",@widthText,@heightText)
    #add sur gtkObject
    @menuV.pack_start(regle.gtkObject ,expand: false, fill: true, padding: @pad)
    #Renvoie vers le diaporama des regles
    regle.onClick{
     }

    meilleurScore=Text.new("meilleur Score",@widthText,@heightText)
    #add sur gtkObject
    @menuV.pack_start(meilleurScore.gtkObject ,expand: false, fill: true, padding: @pad)
    #Renvoie vers la page des meilleurs scores
    meilleurScore.onClick{
     }

    quitter=Text.new("Quitter",@widthText,@heightText)
    #add sur gtkObject
    @menuV.pack_start(quitter.gtkObject ,expand: false, fill: true, padding: @pad)
    quitter.onClick(){
        Gtk.main_quit
    }
    #image de fond
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)

  end
end
