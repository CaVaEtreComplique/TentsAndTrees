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
    titre=Text.new("dEs ArbrEs Et dEs tEntEs",screen.width*0.10,screen.height*0.08)
    menuV.pack_start(titre.gtkObject ,expand: false, fill: true, padding: 50)

    #Bontons de menu
    jouer=Text.new("jouer",screen.width*0.15,screen.height*0.06)
    menuV.pack_start(jouer.gtkObject ,expand: false, fill: true, padding: 50)
    jouer.onClick{
        manager.modeScreen.applyOn(@parent)
    }

    parametre=Text.new("parametres",screen.width*0.15,screen.height*0.06)
    menuV.pack_start(parametre.gtkObject ,expand: false, fill: true, padding: 50)
    parametre.onClick{
        manager.paramScreen.applyOn(@parent)
    }
    regle=Text.new("regle",screen.width*0.15,screen.height*0.06)
    menuV.pack_start(regle.gtkObject ,expand: false, fill: true, padding: 50)
    meilleurScore=Text.new("meilleur Score",screen.width*0.15,screen.height*0.06)
    menuV.pack_start(meilleurScore.gtkObject ,expand: false, fill: true, padding: 50)

    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)

  end
end
