
# @Author: GONCALVES Quentin <QuentinGoncalves>
# @Date:   25-Jan-2019
# @Email:  quentin.goncalves.etu@univ-lemans.fr
# @Filename: RuleScreen.rb
# @Last modified by:   QuentinGoncalves
# @Last modified time: 06-Apr-2019

require 'gtk3'
require File.dirname(__FILE__) + "/../Diapo"
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"
require File.dirname(__FILE__) + "/../Buttons/Text"



##
# =====Presentation
# RuleScreen is an inherited class from the Screen class. This class only needs
# to be initialized and applied, so the only method is the initializer. It
# creates and implements the main menu from the game by creating its buttons.
#
# =====Variables
# The RuleScreen class creates the title size, text size and the padding variables with :
#   @pad=30
#   @widthTitre=screen.width*0.10
#   @heightTitre=screen.height*0.08
#   @widthText=screen.width*0.15
#   @heightText=screen.height*0.04
#
# This class also inherits the screen variable from the Screen class.
#
# The gtkObject is the table where the menuV (a vertical box) is added to create
# the menu buttons.
#
# ===== Implementation
# Here is how a button is implemented on the main menu :
#
# *First* we add some text to the button :
#   jouer=Text.new("jouer",@widthText,@heightText)
#
# *Next* we add the button we just created in the VBox (gtkObject) :
#   @menuV.pack_start(jouer.gtkObject ,expand: false, fill: true, padding: @pad)
#
# *Then* we add the action the button does when it is clicked :
#   jouer.onClick{
#      manager.modeScreen.applyOn(@parent)
#   }
# Here we created a button entitled "jouer" that leads to the game mode menu
# GameModeScreen.
# The other buttons are created by doing this aswell.
#
# *Finally*, when all of the buttons are done we add a background picture with :
#   @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
class RuleScreen < Screen
  def initialize(manager,ic) #:nodoc:
    super(manager.win)
    screen=Constants::SCREEN
    #Variable pour resize le texte
    @pad=Constants::BUTTON_PADDING

    @gtkObject= Gtk::Table.new(3,3)
    @allign=Gtk::Alignment.new(0.5, 0, 0, 0)
    @vBox= Gtk::Box.new(:vertical)
    @diapo = Diapo.new(screen.width*0.6,screen.height*0.6,@textManager,ic)
    @regle=Text.new(@textManager.getScreenTexts("rule" , "title"))
    @retour=Text.new(@textManager.getButtonLabel("rule" , "back"))

    @vBox.pack_start(@regle.gtkObject, expand: false, fill: false, padding: @pad)
    @allign.add(@diapo.box)
    @vBox.pack_start(@allign,expand: false, fill: false, padding: @pad)
    @regle.title
    @vBox.pack_start(@retour.gtkObject, expand: false, fill: false, padding: @pad)
    @gtkObject.attach(@vBox,1,2,1,2)

    @diapo.nextButton.signal_connect("button_press_event"){
      @diapo.nextImage
    }
    @diapo.previousButton.signal_connect("button_press_event"){
      @diapo.previousImage
    }
    @retour.onClick(){
      manager.mainScreen.applyOn(@parent)
    }

    #image de fond
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)

  end
end
