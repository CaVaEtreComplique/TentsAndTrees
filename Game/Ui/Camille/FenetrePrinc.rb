require 'gtk3'
require File.dirname(__FILE__) + "/ModeDeJeu"
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"
require File.dirname(__FILE__) + "/../Buttons/Text"

class FenetrePrinc < Screen
  def initialize(manager)
    super(manager.win)
    screen=Gdk::Screen.default
    #Menu principal
    @gtkObject= Gtk::Table.new(3,3)

  #menuV=box verticale
    menuV=Gtk::Box.new(:vertical)
    @gtkObject.attach(menuV,1,2,0,1)
    #Premiere case : titre
    titre=Text.new("dEs ArbrEs Et dEs tEntEs",screen.width*0.10,screen.height*0.10)
    menuV.add(titre.gtkObject)

    #Bontons de menu
    jouer=Text.new("jouer",screen.width*0.25,screen.height*0.1)
    menuV.add(jouer.gtkObject)
    jouer.onClick{
        manager.modeScreen.applyOn(@gtkObject)
    }

    parametre=Text.new("parametres",screen.width*0.015,screen.height*0.015)
    menuV.add(parametre.gtkObject)
    parametre.onClick{
        manager.paramScreen.applyOn(@gtkObject)
    }
    regle=Text.new("regle",screen.width*0.01,screen.height*0.01)
    menuV.add(regle.gtkObject)
    meilleurScore=Text.new("meilleur Score",screen.width*0.01,screen.height*0.01)
    menuV.add(meilleurScore.gtkObject)

    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)

  end
end
