require 'gtk3'
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

class ModeDeJeu < Screen
  def initialize(parent)
    super(parent)
    #Menu principal
    #menuV=box verticale
    @gtkObject=Gtk::Box.new(:vertical, 100)

    #Premiere case : titre
    titre= "<span font_desc=\"menu\">Mode de Jeu </span>\n"
    monLabel=Gtk::Label.new()
    monLabel.set_markup(titre)
    @gtkObject.add(monLabel)

    #Bontons de menu
    aventure=Button.new(:horizontal,"Aventure")
    @gtkObject.add(aventure.gtkObject)
    timeA=Button.new(:horizontal,"Partie rapide")
    timeA.onClick{

      #Mettre le truc de Corentin mais ca marche pas parce que il a pas fait de classe
    }
    @gtkObject.add(timeA.gtkObject)
    clm=Button.new(:horizontal,"Contre la montre")
    @gtkObject.add(clm.gtkObject)
    retour=Button.new(:horizontal,"retour")
    @gtkObject.add(retour.gtkObject)
    retour.onClick{
        FenetrePrinc.new(@parent).applyOn(@gtkObject)
    }

  end
end
