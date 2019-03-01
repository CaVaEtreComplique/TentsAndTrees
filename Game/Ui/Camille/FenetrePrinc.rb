require 'gtk3'
require File.dirname(__FILE__) + "/ModeDeJeu"
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"
require File.dirname(__FILE__) + "/../Buttons/Text"

class FenetrePrinc < Screen
  def initialize(manager)
    super(manager.win)
    screen=Gdk::Screen.default

    @pad=50
    @widthTitre=screen.width*0.10
    @heightTitre=screen.height*0.08
    @widthText=screen.width*0.15
    @heightText=screen.height*0.06

    #Menu principal
    @gtkObject= Gtk::Table.new(3,3)

    menuV=Gtk::Box.new(:vertical)
    @gtkObject.attach(menuV,1,2,0,1)

    #Premiere case : titre
    titre=Text.new("dEs ArbrEs Et dEs tEntEs",@widthTitre,@heightTitre)
    menuV.pack_start(titre.gtkObject ,expand: false, fill: true, padding: @pad)

    #Bontons de menu
    jouer=Text.new("jouer",@widthText,@heightText)
    menuV.pack_start(jouer.gtkObject ,expand: false, fill: true, padding: @pad)
    #Renvoie vers la page Mode de jeu
    jouer.onClick{
        manager.modeScreen.applyOn(@parent)
    }

    parametre=Text.new("parametres",@widthText,@heightText)
    menuV.pack_start(parametre.gtkObject ,expand: false, fill: true, padding: @pad)
    #Renvoie vers la page parametre
    parametre.onClick{
        manager.paramScreen.applyOn(@parent)
    }
    regle=Text.new("regle",@widthText,@heightText)
    menuV.pack_start(regle.gtkObject ,expand: false, fill: true, padding: @pad)

    meilleurScore=Text.new("meilleur Score",@widthText,@heightText)
    menuV.pack_start(meilleurScore.gtkObject ,expand: false, fill: true, padding: @pad)

    quitter=Text.new("Quitter",@widthText,@heightText)
    menuV.pack_start(quitter.gtkObject ,expand: false, fill: true, padding: @pad)
    quitter.onClick(){
        Gtk.main_quit
    }

    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)

  end
end
