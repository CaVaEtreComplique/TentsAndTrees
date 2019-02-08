require 'gtk3'
require File.dirname(__FILE__) + "/ModeDeJeu"
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"

class FenetrePrinc < Screen
  def initialize(parent)
    super(parent)
    screen=Gdk::Screen.default
    #Menu principal
    @gtkObject= Gtk::Table.new(1,3,false)

  #menuV=box verticale
    menuV=Gtk::Box.new(:vertical,100)
    @gtkObject.attach(menuV,1,2,0,1)
    #Premiere case : titre
    titre= "<span font_desc=\"menu\">Des arbres et des tentes </span>\n"
    monLabel=Gtk::Label.new()
    monLabel.set_markup(titre)
    menuV.add(monLabel)

    #Bontons de menu
    jouer=Button.new(:horizontal,"jouer")

    menuV.add(jouer.gtkObject)
    jouer.onClick{
        ModeDeJeu.new(@parent).applyOn(@gtkObject)
    }

    parametre=Button.new(:horizontal,"parametres")
    menuV.add(parametre.gtkObject)
    parametre.onClick{
        Parametre.new(@parent).applyOn(@gtkObject)
    }
    regle=Button.new(:horizontal,"regle")
    menuV.add(regle.gtkObject)
    meilleurScore=Button.new(:horizontal,"meilleur Score")
    menuV.add(meilleurScore.gtkObject)

    #@gtkObject.attach(Gtk::Layout.new.add(Gtk::Image.new(pixbuf: @buffer)),0,3,0,1)

  end
end
